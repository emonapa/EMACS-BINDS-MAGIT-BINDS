;;; -------------------------------
;;; Václav: Emacs init (s MELPA & auto-installem)
;;; -------------------------------

;; Ukládej custom nastavení do separátního souboru
(setq custom-file "~/.emacs.custom.el")

;; Repozitáře s balíčky (GNU, NonGNU, MELPA)
(require 'package)
(setq package-archives
      '(("gnu"     . "https://elpa.gnu.org/packages/")
        ("nongnu"  . "https://elpa.nongnu.org/nongnu/")
        ("melpa"   . "https://melpa.org/packages/")))
(unless package--initialized (package-initialize))
(unless package-archive-contents (package-refresh-contents))

(require 'subr-x)
(require 'seq)

;; Pomocné „fallback“ funkce, kdyby ještě nebyl načten rc.el
(unless (fboundp 'rc/require)
  (defun rc/require (&rest pkgs)
    (dolist (pkg pkgs)
      (condition-case _
          (require pkg)
        (error nil)))))

(unless (fboundp 'rc/require-theme)
  (defun rc/require-theme (theme)
    "Nainstaluje balíček <theme>-theme a načte theme."
    (let* ((pkg (intern (format "%s-theme" theme))))
      (unless (package-installed-p pkg)
        (ignore-errors (package-install pkg)))
      (load-theme theme t)
      ;; hned po load-theme jednorázově oprav faces:
      (when (fboundp 'rc/fix-nil-faces) (rc/fix-nil-faces)))))

(defun rc/fix-nil-faces ()
  (dolist (f '(tab-bar-tab-inactive tab-bar-tab highlight secondary-selection fringe region))
    (when (facep f)
      (let ((bg (face-attribute f :background nil t))
            (fg (face-attribute f :foreground nil t))
            (inh (face-attribute f :inherit   nil t)))
        ;; Opravuj jen skutečné nil – jinak nech barvy tématu na pokoji
        (when (null bg)  (set-face-attribute f nil :background 'unspecified))
        (when (null fg)  (set-face-attribute f nil :foreground 'unspecified))
        (when (null inh) (set-face-attribute f nil :inherit   'unspecified))))))




;; Auto-instalace používaných balíčků (včetně helm-git-grep)
(let ((packages-to-install
       '(helm helm-git-grep helm-ls-git helm-rg
         smex ido-completing-read+
         paredit magit multiple-cursors
         yasnippet company
         haskell-mode typescript-mode tide flycheck
         proof-general move-text
         gruber-darker-theme zenburn-theme
         yaml-mode tuareg lua-mode graphviz-dot-mode
         rust-mode csharp-mode nim-mode jinja2-mode
         markdown-mode purescript-mode nix-mode
         dockerfile-mode toml-mode nginx-mode
         kotlin-mode go-mode php-mode racket-mode
         qml-mode rfc-mode sml-mode
         powershell glsl-mode editorconfig js2-mode cmake-mode
         projectile helm-projectile)))
  (dolist (p packages-to-install)
    (unless (package-installed-p p)
      (ignore-errors (package-install p)))))

;; Lokální cesty s tvými módy
(add-to-list 'load-path "~/.emacs.local/")

;; Načti vlastní rc soubory (pokud existují)
(ignore-errors (load "~/.emacs.rc/rc.el"))
(ignore-errors (load "~/.emacs.rc/misc-rc.el"))
(ignore-errors (load "~/.emacs.rc/org-mode-rc.el"))
(ignore-errors (load "~/.emacs.rc/autocommit-rc.el"))

;;; -------------------------------
;;; Vzhled
;;; -------------------------------
(defun rc/get-default-font ()
  (cond
   ((eq system-type 'windows-nt) "Consolas-13")
   ((eq system-type 'gnu/linux)  "Iosevka-20")
   (t                            "DejaVu Sans Mono-12")))

(defun rc/set-first-available-font (fonts)
  "Vyber první dostupný font z FONTS (se jménem včetně velikosti)."
  (when-let* ((name (seq-find (lambda (f) (find-font (font-spec :name f))) fonts)))
    (add-to-list 'default-frame-alist `(font . ,name))))

(rc/set-first-available-font
 '("Iosevka-20"
   "JetBrainsMono Nerd Font-12"
   "JetBrains Mono-12"
   "FiraCode-12"
   "DejaVu Sans Mono-12"))


(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(setq inhibit-startup-screen t)

(rc/require-theme 'gruber-darker)
;; (rc/require-theme 'zenburn)

;; Příklad úpravy faces pro zenburn (až když je načten):
(eval-after-load 'zenburn-theme
  '(set-face-attribute 'line-number nil :inherit 'default))

;;; -------------------------------
;;; IDO + SMEX
;;; -------------------------------
(rc/require 'smex 'ido-completing-read+)
(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; -------------------------------
;;; C/C++ styly
;;; -------------------------------
(setq-default c-basic-offset 4
              c-default-style '((java-mode . "java")
                                (awk-mode  . "awk")
                                (other     . "bsd")))
(add-hook 'c-mode-hook (lambda () (c-toggle-comment-style -1)))

;;; -------------------------------
;;; Paredit (Lisp jazyky)
;;; -------------------------------
;;;(rc/require 'paredit)
;;;(defun rc/turn-on-paredit () (paredit-mode 1))
;;;(dolist (hook '(emacs-lisp-mode-hook clojure-mode-hook lisp-mode-hook
;;;                  common-lisp-mode-hook scheme-mode-hook racket-mode-hook))
;;;  (add-hook hook 'rc/turn-on-paredit))
(electric-pair-mode 1)


;;; -------------------------------
;;; Emacs Lisp drobnosti
;;; -------------------------------
(add-hook 'emacs-lisp-mode-hook
          (lambda () (local-set-key (kbd "C-c C-j") 'eval-print-last-sexp)))
(add-to-list 'auto-mode-alist '("Cask" . emacs-lisp-mode))

;;; -------------------------------
;;; Lokální módy (z ~/.emacs.local) – nahrávej, jen pokud existují
;;; -------------------------------
(dolist (m '(uxntal-mode basm-mode fasm-mode porth-mode noq-mode jai-mode simpc-mode c3-mode))
  (ignore-errors (require m)))
(add-to-list 'auto-mode-alist '("\\.asm\\'" . fasm-mode))
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
(add-to-list 'auto-mode-alist '("\\.[b]\\'" . simpc-mode))

;;; -------------------------------
;;; Whitespace + trim
;;; -------------------------------
(defun rc/set-up-whitespace-handling ()
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))
(dolist (hook '(tuareg-mode-hook c++-mode-hook c-mode-hook simpc-mode-hook
                 emacs-lisp-mode-hook java-mode-hook lua-mode-hook rust-mode-hook
                 scala-mode-hook markdown-mode-hook haskell-mode-hook
                 python-mode-hook erlang-mode-hook asm-mode-hook fasm-mode-hook
                 go-mode-hook nim-mode-hook yaml-mode-hook porth-mode-hook))
  (add-hook hook 'rc/set-up-whitespace-handling))

;;; -------------------------------
;;; New window + cmd
;;; -------------------------------
(defun my/split-and-ansi-term-here ()
  (interactive)
  (let ((dir (or (and buffer-file-name (file-name-directory buffer-file-name))
                 default-directory)))
    (split-window-below)
    (other-window 1)
    (let ((default-directory dir))
      (ansi-term "/bin/bash"))))
(global-set-key (kbd "C-c t") 'my/split-and-ansi-term-here)



;;; Dopici nechci soubor z podslozky...
(setq ido-auto-merge-work-directories-length -1)

;;; EDIFF
(with-eval-after-load 'magit
  (defun my/magit-smerge-ediff-at-point ()
    "Otevři soubor na řádku v Magit Status a spusť smerge-ediff."
    (interactive)
    (let ((file (magit-file-at-point)))
      (unless file
        (user-error "Na tomto řádku není soubor"))
      ;; otevřít soubor v aktuálním okně a spustit smerge-ediff
      (find-file file)
      (smerge-ediff)))

  ;; odmapovat původní a namapovat náš
  (define-key magit-status-mode-map (kbd "e") nil)
  (define-key magit-status-mode-map (kbd "e") #'my/magit-smerge-ediff-at-point))



(with-eval-after-load 'magit
  ;; Všechny magit “section” buffery
  (define-key magit-section-mode-map (kbd "<C-tab>") nil)              ;; uvolni C-Tab
  ;; Přesuň cyklování sekcí na Ctrl+Shift+Tab (obě notace kvůli různým WM)
  (define-key magit-section-mode-map (kbd "<C-S-tab>") #'magit-section-cycle)
  (define-key magit-section-mode-map (kbd "<C-S-iso-lefttab>") #'magit-section-cycle))

;;; GIT
;; stejné okno (neotvírej nové frame)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; horizontální split = 2 panely vedle sebe
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-merge-split-window-function 'split-window-horizontally)

;; jemné zvýraznění rozdílů
(setq ediff-forward-word-function 'forward-char)


;;; --- Select all (označit celý buffer) ---
;; Varianta A: přemapuj Ctrl + A na "Select All"
(global-set-key (kbd "C-a") 'mark-whole-buffer)


;;; -------------------------------
;;; Duplikace řádku NEBO označené oblasti
;;; -------------------------------
(defun my/duplicate-line-or-region ()
  "Když je aktivní výběr, duplikuje ho za něj. Jinak duplikuje aktuální řádek."
  (interactive)
  (if (use-region-p)
      (let* ((beg (region-beginning))
             (end (region-end))
             (text (buffer-substring beg end)))
        (goto-char end)
        (insert text))
    (let ((col (current-column)))
      (save-excursion
        (move-beginning-of-line 1)
        (let ((beg (point)))
          (move-end-of-line 1)
          (let ((text (buffer-substring beg (point))))
            (end-of-line)
            (insert "\n" text))))
      (move-to-column col))))
;; Zkratka: Ctrl + C, D
(global-set-key (kbd "C-c d") 'my/duplicate-line-or-region)



;;; -------------------------------
;;; Multiple cursors
;;; -------------------------------
(rc/require 'multiple-cursors)

;; 1) nejdřív vše „odsvážeme“, kdyby to kolidovalo
(global-unset-key (kbd "C-,"))
(global-unset-key (kbd "C-."))
(global-unset-key (kbd "C-M-,"))
(global-unset-key (kbd "C-M-."))

;; 2) zajistíme, že je multiple-cursors k dispozici
(require 'multiple-cursors nil t)

;; 3) nastavíme CZ-friendly bindy pro multiple-cursors
(global-set-key (kbd "C-.")   #'mc/mark-next-like-this)        ;; další shoda
(global-set-key (kbd "C-,")   #'mc/mark-previous-like-this)    ;; předchozí shoda
(global-set-key (kbd "C-M-.") #'mc/skip-to-next-like-this)     ;; přeskočit aktuální a dál
(global-set-key (kbd "C-M-,") #'mc/skip-to-previous-like-this) ;; přeskočit aktuální a zpět
(global-set-key (kbd "C-c C-,") #'mc/mark-all-like-this)       ;; označit všechny shody
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;; Přidat kurzor na řádek níže/výše (jako ve VS Code)
(global-set-key (kbd "C-S-<down>")   #'mc/mark-next-like-this)
(global-set-key (kbd "C-S-<up>")   #'mc/mark-previous-like-this)


;;; -------------------------------
;;; === CZ-friendly Undo/Redo ===
;; 1) Pokus o přímé bindy (v GUI Emacsu většinou projde)
;;; -------------------------------
(ignore-errors (global-set-key (kbd "C-ů") #'undo))
(cond
  ((fboundp 'undo-redo)
   (ignore-errors (global-set-key (kbd "C-§") #'undo-redo)))
  ((fboundp 'undo-tree-redo)
   (ignore-errors (global-set-key (kbd "C-§") #'undo-tree-redo)))
  ((fboundp 'undo-fu-only-redo)
   (ignore-errors (global-set-key (kbd "C-§") #'undo-fu-only-redo))))


;;; -------------------------------
;;; klávesová zkratka: Ctrl + X, K
;;; -------------------------------
(defun my/kill-other-buffers ()
  "Zabij všechny buffery kromě aktuálního."
  (interactive)
  (mapc #'kill-buffer (delq (current-buffer) (buffer-list))))
(global-set-key (kbd "C-x K") #'my/kill-other-buffers)


;;; -------------------------------
;;; Další okno
;;; -------------------------------
(when (display-graphic-p)
  ;; dopředu: Ctrl+Tab
  (global-set-key (kbd "<C-tab>") #'other-window)
  ;; zpět: Ctrl+Shift+Tab (dvě notace kvůli kompatibilitě)
  (global-set-key (kbd "<C-S-iso-lefttab>")
                  (lambda () (interactive) (other-window -1)))
  (global-set-key (kbd "<C-S-tab>")
                  (lambda () (interactive) (other-window -1))))
;; stejné chování i v minibufferu
(dolist (map (list minibuffer-local-map
                   minibuffer-local-ns-map
                   minibuffer-local-completion-map
                   minibuffer-local-must-match-map
                   minibuffer-local-isearch-map))
  (when (display-graphic-p)
    (define-key map (kbd "<C-tab>") #'other-window)
    (define-key map (kbd "<C-S-iso-lefttab>")
      (lambda () (interactive) (other-window -1)))
    (define-key map (kbd "<C-S-tab>")
      (lambda () (interactive) (other-window -1)))))


;;; -------------------------------
;;; TAB/Shift-TAB na označený text
;;; -------------------------------
(defun my/indent-region-or-tab ()
  "Když je aktivní výběr, odsaď vybrané řádky o `tab-width`. Jinak standardní Tab."
  (interactive)
  (if (use-region-p)
      (let* ((deactivate-mark nil)
             (rb (save-excursion (goto-char (region-beginning))
                                 (line-beginning-position)))
             (re (save-excursion (goto-char (region-end))
                                 (line-end-position))))
        (indent-rigidly rb re tab-width))
    (indent-for-tab-command)))
(defun my/outdent-region ()
  "Když je aktivní výběr, uber odsazení vybraných řádků o `tab-width`."
  (interactive)
  (when (use-region-p)
    (let* ((deactivate-mark nil)
           (rb (save-excursion (goto-char (region-beginning))
                               (line-beginning-position)))
           (re (save-excursion (goto-char (region-end))
                               (line-end-position))))
      (indent-rigidly rb re (- tab-width)))))
;; Bind: Tab = posunout výběr doprava / běžný Tab; Shift+Tab = posunout doleva
(global-set-key (kbd "<tab>") #'my/indent-region-or-tab)
(global-set-key (kbd "<backtab>") #'my/outdent-region)         ;; Shift+Tab
(global-set-key (kbd "<S-tab>") #'my/outdent-region)           ;; některá prostředí
(global-set-key (kbd "<S-iso-lefttab>") #'my/outdent-region)   ;; jiná prostředí




;;; -------------------------------
;;; Číslování řádků (Emacs 26+)
;;; -------------------------------
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))

;;; -------------------------------
;;; Magit
;;; -------------------------------
(rc/require 'cl-lib 'magit)
(setq magit-auto-revert-mode nil)
(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)


;;; -------------------------------
;;; Dired
;;; -------------------------------
(require 'dired-x)
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t)
;; Posílat mazání do Koše místo trvalého smazání
(setq delete-by-moving-to-trash t)


;;; -------------------------------
;;; Helm (+ git grep)
;;; -------------------------------
(rc/require 'helm 'helm-git-grep 'helm-ls-git)
(setq helm-ff-transformer-show-only-basename nil)
(global-set-key (kbd "C-c h t") 'helm-projectile)
(global-set-key (kbd "C-c h g g") 'helm-git-grep)
(global-set-key (kbd "C-c h g l") 'helm-ls-git-ls)
(global-set-key (kbd "C-c h d") 'helm-find-files)
(global-set-key (kbd "C-c h s") 'helm-rg)
(global-set-key (kbd "C-c h f") 'helm-find)
(global-set-key (kbd "C-c h a") 'helm-org-agenda-files-headings)
(global-set-key (kbd "C-c h r") 'helm-recentf)
(global-set-key (kbd "C-x k") 'kill-buffer-and-window)

;;; -------------------------------
;;; Yasnippet
;;; -------------------------------
(rc/require 'yasnippet)
(setq yas/triggers-in-field nil)
(setq yas-snippet-dirs '("~/.emacs.snippets/"))
(yas-global-mode 1)

;;; -------------------------------
;;; Word-wrap v Markdownu
;;; -------------------------------
(defun rc/enable-word-wrap () (toggle-word-wrap 1))
(add-hook 'markdown-mode-hook 'rc/enable-word-wrap)

;;; -------------------------------
;;; HTML/XML
;;; -------------------------------
(add-to-list 'auto-mode-alist '("\\.html\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xsd\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.ant\\'" . nxml-mode))

;;; -------------------------------
;;; TRAMP
;;; -------------------------------
(setq tramp-auto-save-directory "/tmp")

;;; -------------------------------
;;; PowerShell
;;; -------------------------------
(ignore-errors (require 'powershell))
(add-to-list 'auto-mode-alist '("\\.ps1\\'" . powershell-mode))
(add-to-list 'auto-mode-alist '("\\.psm1\\'" . powershell-mode))

;;; -------------------------------
;;; Eldoc
;;; -------------------------------
(add-hook 'emacs-lisp-mode-hook (lambda () (eldoc-mode 1)))

;;; -------------------------------
;;; Company (globálně), vypnout v tuareg
;;; -------------------------------
(rc/require 'company)
(global-company-mode)
(add-hook 'tuareg-mode-hook (lambda () (company-mode 0)))

;;; -------------------------------
;;; TypeScript + Tide (+ Flycheck)
;;; -------------------------------
(rc/require 'typescript-mode 'tide 'flycheck)
(defun rc/turn-on-tide-and-flycheck ()
  (tide-setup)
  (flycheck-mode 1))
(add-hook 'typescript-mode-hook 'rc/turn-on-tide-and-flycheck)
(add-to-list 'auto-mode-alist '("\\.mts\\'" . typescript-mode))

;;; -------------------------------
;;; Proof General (Coq)
;;; -------------------------------
(rc/require 'proof-general)
(add-hook 'coq-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-q C-n")
                           'proof-assert-until-point-interactive)))

;;; -------------------------------
;;; LaTeX
;;; -------------------------------
(add-hook 'tex-mode-hook
          (lambda () (add-to-list 'tex-verbatim-environments "code")))
(setq font-latex-fontify-sectioning 'color)

;;; -------------------------------
;;; Move Text
;;; -------------------------------
(rc/require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;;; -------------------------------
;;; Astyle formatter (pro simpc-mode)
;;; -------------------------------
(defun astyle-buffer (&optional _justify)
  (interactive)
  (let ((saved-line-number (line-number-at-pos)))
    (shell-command-on-region (point-min) (point-max) "astyle --style=kr" nil t)
    (goto-char (point-min))
    (forward-line (1- saved-line-number))))
(add-hook 'simpc-mode-hook (lambda () (setq-local fill-paragraph-function 'astyle-buffer)))

;;; -------------------------------
;;; Compile: regex pro chyby
;;; -------------------------------
(require 'compile)
(add-to-list 'compilation-error-regexp-alist
             '("\\([a-zA-Z0-9\\.]+\\)(\\([0-9]+\\)\\(,\\([0-9]+\\)\\)?) \\(Warning:\\)?"
               1 2 (4) (5)))

;;; -------------------------------
;;; Načti custom-file, pokud existuje
;;; -------------------------------
(when (file-exists-p custom-file)
  (load-file custom-file))


;;; --- Šipky pro procházení souborů ---

;; HELM (helm-find-files): vlevo = o adresář výš, vpravo = vstoupit/otevřít (persist. action)
(with-eval-after-load 'helm-files
  (define-key helm-find-files-map (kbd "<left>")
    (if (fboundp 'helm-find-files-up-one-level)
        'helm-find-files-up-one-level
   'helm-ff-run-up-one-level))           ;; fallback, když by se jmenovalo jinak
  (define-key helm-find-files-map (kbd "<right>") 'helm-execute-persistent-action)
  (define-key helm-read-file-map (kbd "<left>")
    (if (fboundp 'helm-find-files-up-one-level)
        'helm-find-files-up-one-level
      'helm-ff-run-up-one-level))
  (define-key helm-read-file-map (kbd "<right>") 'helm-execute-persistent-action))

;; DIRED: vlevo = o adresář výš, vpravo = otevřít/vstoupit
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "<left>")  'dired-up-directory)
  (define-key dired-mode-map (kbd "<right>") 'dired-find-file))

;; IDO (Open File dialog): vlevo = o adresář výš, vpravo = potvrdit výběr
(with-eval-after-load 'ido
  ;; „o adresář výš“ (normálně dělá Backspace)
  (define-key ido-file-completion-map (kbd "<left>") 'ido-delete-backward-updir)
  ;; potvrdit aktuální kandidát (u složky to vejde dovnitř, u souboru otevře)
  (define-key ido-file-completion-map (kbd "<right>") 'ido-exit-minibuffer))



(add-hook 'emacs-startup-hook #'rc/fix-nil-faces)
