;;; -------------------------------
;;; Václav: Emacs init (s MELPA & auto-installem)
;;; -------------------------------

;; Ukladej custom nastaveni do separatniho souboru
(setq custom-file "~/.emacs.custom.el")

;; Repozitare s balicky (GNU, NonGNU, MELPA)
(require 'package)
(setq package-archives
      '(("gnu"     . "https://elpa.gnu.org/packages/")
        ("nongnu"  . "https://elpa.nongnu.org/nongnu/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa"   . "https://melpa.org/packages/")))
(unless package--initialized (package-initialize))

;; Na omezenych pocitacich pri startu nevyzaduj sit.
;; Pro automatickou instalaci nastav na t pred nactenim tohoto souboru.
(defvar rc/auto-install-packages nil)
(when (and rc/auto-install-packages
           (not package-archive-contents))
  (ignore-errors (package-refresh-contents)))

(require 'subr-x)
(require 'seq)

;; Pomocne „fallback“ funkce, kdyby jeste nebyl nacten rc.el
(unless (fboundp 'rc/require)
  (defun rc/require (&rest pkgs)
    (dolist (pkg pkgs)
      (condition-case _
          (require pkg)
        (error nil)))))

(unless (fboundp 'rc/require-theme)
  (defun rc/require-theme (theme)
    "Nainstaluje balicek <theme>-theme a nacte theme."
    (let* ((pkg (intern (format "%s-theme" theme))))
      (unless (package-installed-p pkg)
        (ignore-errors (package-install pkg)))
      (load-theme theme t)
      ;; hned po load-theme jednorazove oprav faces:
      (when (fboundp 'rc/fix-nil-faces) (rc/fix-nil-faces)))))

(defun my/python-indent-setup ()
  ;; mezery místo TAB
  (setq-local indent-tabs-mode nil)
  (setq-local tab-width 4)
  (setq-local python-indent-offset 4)

  ;; vypnout python "chytrý" indent engine
  (setq-local python-indent-guess-indent-offset nil)
  (setq-local python-indent-guess-indent-offset-verbose nil)

  ;; ENTER nesmí autoindentovat
  (electric-indent-local-mode -1)

  ;; TAB = jen 4 mezery, žádná magie
  (setq-local tab-always-indent nil)
)

(add-hook 'python-mode-hook #'my/python-indent-setup)



(defun rc/fix-nil-faces ()
  (dolist (f '(tab-bar-tab-inactive tab-bar-tab highlight secondary-selection fringe region))
    (when (facep f)
      (let ((bg (face-attribute f :background nil t))
            (fg (face-attribute f :foreground nil t))
            (inh (face-attribute f :inherit   nil t)))
        ;; Opravuj jen skutecne nil – jinak nech barvy tematu na pokoji
        (when (null bg)  (set-face-attribute f nil :background 'unspecified))
        (when (null fg)  (set-face-attribute f nil :foreground 'unspecified))
        (when (null inh) (set-face-attribute f nil :inherit   'unspecified))))))

;; Auto-instalace pouzivanych balicku (vcetne helm-git-grep)
(let ((packages-to-install
       '(helm helm-git-grep helm-ls-git helm-rg
         smex ido-completing-read+
         paredit magit multiple-cursors
         yasnippet company
         haskell-mode typescript-mode tide flycheck
         proof-general move-text
         gruber-darker-theme zenburn-theme catppuccin-theme kanagawa-theme
         yaml-mode tuareg lua-mode graphviz-dot-mode
         rust-mode csharp-mode nim-mode jinja2-mode
         markdown-mode purescript-mode nix-mode
         dockerfile-mode toml-mode nginx-mode
         kotlin-mode go-mode php-mode racket-mode
         qml-mode rfc-mode sml-mode
         powershell glsl-mode editorconfig js2-mode cmake-mode
         projectile helm-projectile
         vterm
         web-mode
         eglot)))
  (dolist (p packages-to-install)
    (unless (or (package-installed-p p)
                (not rc/auto-install-packages))
      (ignore-errors (package-install p)))))

;; Lokalni cesty s tvymi mody
(add-to-list 'load-path "~/.emacs.local/")

;; Nacti vlastni rc soubory (pokud existuji)
(ignore-errors (load "~/.emacs.rc/rc.el"))
(ignore-errors (load "~/.emacs.rc/misc-rc.el"))
(ignore-errors (load "~/.emacs.rc/org-mode-rc.el"))
(ignore-errors (load "~/.emacs.rc/autocommit-rc.el"))

;;; -------------------------------
;;; Cislovani radku globalne
;;; -------------------------------
(setq display-line-numbers-type t)   ;; t = absolutni, 'relative = relativni
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode 1)
  (dolist (hook '(vterm-mode-hook
                  dired-mode-hook
                  term-mode-hook))
    (add-hook hook (lambda () (display-line-numbers-mode 0)))))


;;; -------------------------------
;;; Vzhled, barvy
;;; -------------------------------
(defun rc/get-default-font ()
  (cond
   ((eq system-type 'windows-nt) "Consolas-13")
   ((eq system-type 'gnu/linux)  "Iosevka-20")
   (t                            "DejaVu Sans Mono-12")))

(defun rc/set-first-available-font (fonts)
  "Vyber prvni dostupny font z FONTS (se jmenem vcetne velikosti)."
  (when-let* ((name
               (and (display-graphic-p)
                    (seq-find
                     (lambda (f)
                       (ignore-errors (find-font (font-spec :name f))))
                     fonts))))
    (ignore-errors (set-frame-font name nil t))
    (add-to-list 'default-frame-alist (cons 'font name))))

;(rc/set-first-available-font
; '("Iosevka-20"
;   "JetBrainsMono Nerd Font-12"
;   "JetBrains Mono-12"
;   "FiraCode-12"
;   "DejaVu Sans Mono-12"))

(rc/set-first-available-font
 '(

   "JetBrains Mono-12"
   "FiraCode-12"
   "DejaVu Sans Mono-12"))



(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(setq inhibit-startup-screen t)

(setq select-enable-clipboard t
      select-enable-primary   nil)

;;(rc/require-theme 'gruber-darker)
;;(set-background-color "#1E1E1E")
;; (rc/require-theme 'zenburn)

(unless (ignore-errors (load-theme 'kanagawa-wave t) t)
  (ignore-errors (load-theme 'wombat t)))
;; barva normalni fontu na bilou
;;(set-face-attribute 'default nil :foreground "#D4D4D4")
(set-face-attribute 'default nil :foreground "#F2F2F2")

(set-face-attribute 'font-lock-keyword-face nil :foreground "#C084FC")
(set-face-attribute 'font-lock-function-name-face nil :foreground "#60A5FA")
(set-face-attribute 'font-lock-variable-name-face nil :foreground "#E879F9")
(set-face-attribute 'font-lock-string-face nil :foreground "#86EFAC")
(set-face-attribute 'font-lock-type-face nil :foreground "#2DD4BF")

(when (facep 'ansi-color-green)
  (set-face-attribute 'ansi-color-green nil :foreground "#4ADE80"))

;; Priklad upravy faces pro zenburn (az kdyz je nacten):
;;(eval-after-load 'zenburn-theme
;;  '(set-face-attribute 'line-number nil :inherit 'default))

;;; -------------------------------
;;; IDO + SMEX
;;; -------------------------------
(rc/require 'smex 'ido-completing-read+)
(ido-mode 1)
(ido-everywhere 1)
(when (fboundp 'ido-ubiquitous-mode)
  (ido-ubiquitous-mode 1))
(global-set-key (kbd "M-x")
                (if (fboundp 'smex) #'smex #'execute-extended-command))
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
;;; Pairing zavorek
;;; -------------------------------
(electric-pair-mode 1)

;;; -------------------------------
;;; Emacs Lisp drobnosti
;;; -------------------------------
(add-hook 'emacs-lisp-mode-hook
          (lambda () (local-set-key (kbd "C-c C-j") 'eval-print-last-sexp)))
(add-to-list 'auto-mode-alist '("Cask" . emacs-lisp-mode))

;;; -------------------------------
;;; Lokalni mody (z ~/.emacs.local)
;;; -------------------------------
(dolist (m '(uxntal-mode basm-mode fasm-mode porth-mode noq-mode jai-mode simpc-mode c3-mode))
  (ignore-errors (require
m)))
(when (fboundp 'fasm-mode)
  (add-to-list 'auto-mode-alist '("\\.asm\\'" . fasm-mode)))
(when (fboundp 'simpc-mode)
  (add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
  (add-to-list 'auto-mode-alist '("\\.[b]\\'" . simpc-mode)))

;;; -------------------------------
;;; Whitespace + trim
;;; -------------------------------
(require 'whitespace)

;;(defun rc/set-up-whitespace-handling ()
;;  "Zapni whitespace-mode a trim trailing mezer pri ulozeni v aktualnim bufferu."
;;  (whitespace-mode 0)
;;  (setq show-trailing-whitespace t)
;;  (add-hook 'before-save-hook #'delete-trailing-whitespace nil t))

(defun rc/set-up-whitespace-handling ()
  (setq show-trailing-whitespace t)
  (add-hook 'before-save-hook #'delete-trailing-whitespace nil t))

(global-whitespace-mode 0)

;; Vetsina kodovacich modu - trim pri ulozeni
(dolist (hook '(tuareg-mode-hook c++-mode-hook c-mode-hook simpc-mode-hook
                 emacs-lisp-mode-hook java-mode-hook lua-mode-hook rust-mode-hook
                 scala-mode-hook haskell-mode-hook
                 python-mode-hook erlang-mode-hook asm-mode-hook fasm-mode-hook
                 go-mode-hook nim-mode-hook yaml-mode-hook porth-mode-hook))
  (add-hook hook #'rc/set-up-whitespace-handling))

(defun rc/md-trim-except-hard-breaks ()
  "V Markdownu smaze trailing whitespace, ale zachova presne dve mezery na konci radku (hard break)."
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "[ \t]+$" nil t)
      (let ((len (- (match-end 0) (match-beginning 0))))
        (unless (= len 2)
          (replace-match "" t t))))))

(add-hook 'markdown-mode-hook
          (lambda ()
            ;; jen vizualni zvyrazneni
            (whitespace-mode 1)
            (setq-local show-trailing-whitespace nil)

            ;; odstrel vseho, co by mohlo trimovat pri save
            (remove-hook 'before-save-hook #'delete-trailing-whitespace t)
            (remove-hook 'before-save-hook #'whitespace-cleanup t)
            (remove-hook 'write-file-functions #'delete-trailing-whitespace t)

            ;; pokud pouzivas ws-butler (kdyby nahodou)
            (when (bound-and-true-p ws-butler-mode)
              (ws-butler-mode -1))

            ;; pokud je aktivni editorconfig v tomhle bufferu, tak pryc
            (when (bound-and-true-p editorconfig-mode)
              (editorconfig-mode -1))

            ;; na konec hooku, aby to prebilo vsechno ostatni
            (add-hook 'before-save-hook #'rc/md-trim-except-hard-breaks t t)))

;;; -------------------------------
;;; New window + vterm
;;; -------------------------------
(rc/require 'vterm)

(defun my/vterm-new-here ()
  "Otevri novy, jednoznacne pojmenovany vterm dole v aktualnim adresari."
  (interactive)
  (let* ((dir (or (and buffer-file-name (file-name-directory buffer-file-name))
                  default-directory))
         (vterm-buffer-name (generate-new-buffer-name "vterm")))
    (split-window-below)
    (other-window 1)
    (let ((default-directory dir))
      (if (fboundp 'vterm)
          (vterm)
        (shell (generate-new-buffer-name "*shell*"))))))


(global-set-key (kbd "C-x t")  #'my/vterm-new-here)


;;; -------------------------------
;;; GDB
;;; -------------------------------
(setq gdb-many-windows t
      gdb-show-main t)

;;; -------------------------------
;;; Isearch z regionu
;;; -------------------------------
(defun my/isearch-forward-from-region ()
  "Kdyz je aktivni region, pouzij ho jako dotaz pro isearch-forward."
  (interactive)
  (let ((sel (when (use-region-p)
               (buffer-substring-no-properties (region-beginning) (region-end)))))
    (deactivate-mark)
    (isearch-forward)
    (when sel (isearch-yank-string sel))))

(defun my/isearch-backward-from-region ()
  "Kdyz je aktivni region, pouzij ho jako dotaz pro isearch-backward."
  (interactive)
  (let ((sel (when (use-region-p)
               (buffer-substring-no-properties (region-beginning) (region-end)))))
    (deactivate-mark)
    (isearch-backward)
    (when sel (isearch-yank-string sel))))

(global-set-key (kbd "C-s") #'my/isearch-forward-from-region)
(global-set-key (kbd "C-r") #'my/isearch-backward-from-region)

;;; -------------------------------
;;; Kopirovani ve vtermu
;;; -------------------------------
(with-eval-after-load 'vterm
  (defun my/vterm-copy-region-or-enter-copy-mode ()
    "Ve vtermu zkopiruj aktualni vyber.
Kdyz neni nic oznaceno, zapni vterm-copy-mode a nech uzivatele oznacit."
    (interactive)
    (if (use-region-p)
        (progn
          (kill-ring-save (region-beginning) (region-end))
          (deactivate-mark))
      (vterm-copy-mode 1)))

  (define-key vterm-mode-map
              (kbd "M-w")
              #'my/vterm-copy-region-or-enter-copy-mode)
  (define-key vterm-copy-mode-map
              (kbd "M-w")
              #'my/vterm-copy-region-or-enter-copy-mode))

;;; -------------------------------
;;; POHYB O SLOVO
;;; -------------------------------
(global-set-key (kbd "C-<right>") #'forward-symbol)

(global-set-key (kbd "C-<left>")
                (lambda ()
                  (interactive)
                  (forward-symbol -1)))

;;; -------------------------------
;;; IDO: nechci auto-merge podslozek
;;; -------------------------------
(setq ido-auto-merge-work-directories-length -1)

;;; -------------------------------
;;; Magit + Ediff helper
;;; -------------------------------
(with-eval-after-load 'magit
  (defun my/magit-smerge-ediff-at-point ()
    "Otevri soubor na radku v Magit Status a spust smerge-ediff."
    (interactive)
    (let ((file (magit-file-at-point)))
      (unless file
        (user-error "Na tomto radku neni soubor"))
      (find-file file)
      (smerge-ediff)))

  (define-key magit-status-mode-map (kbd "e") nil)
  (define-key magit-status-mode-map (kbd "e") #'my/magit-smerge-ediff-at-point))

(with-eval-after-load 'magit
  ;; Vsechny magit “section” buffery
  (define-key magit-section-mode-map (kbd "<C-tab>") nil)
  (define-key magit-section-mode-map (kbd "<C-S-tab>") #'magit-section-cycle)
  (define-key magit-section-mode-map (kbd "<C-S-iso-lefttab>") #'magit-section-cycle))

;;; GIT Ediff nastaveni
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-merge-split-window-function 'split-window-horizontally)
(setq ediff-forward-word-function 'forward-char)

;;; -------------------------------
;;; Auto reread souboru z disku
;;; -------------------------------
(global-auto-revert-mode 1)
(setq auto-revert-verbose nil)

;;; -------------------------------
;;; Select all na C-a
;;; -------------------------------
(global-set-key (kbd "C-a") 'mark-whole-buffer)


(defun my/delete-char-or-region ()
  "Kdyz je aktivni region, smaze ho bez ukladani do kill-ring.
Jinak smaze nasledujici znak."
  (interactive)
  (if (use-region-p)
      (delete-region (region-beginning) (region-end))
    (delete-char 1)))

(defun my/backspace-or-region ()
  "Kdyz je aktivni region, smaze ho bez ukladani do kill-ring.
Jinak smaze predchozi znak."
  (interactive)
  (if (use-region-p)
      (delete-region (region-beginning) (region-end))
    (delete-char -1)))

(defun my/delete-line ()
  "Smaze od kurzoru do konce radku bez ukladani do kill-ring.
Kdyz je kurzor na konci radku, smaze newline."
  (interactive)
  (if (use-region-p)
      (delete-region (region-beginning) (region-end))
    (delete-region (point) (if (eolp)
                               (1+ (point))
                             (line-end-position)))))

(defun my/delete-whole-line ()
  "Smaze cely radek vcetne newline bez ukladani do kill-ring."
  (interactive)
  (delete-region (line-beginning-position)
                 (min (point-max) (1+ (line-end-position)))))

(global-set-key [delete]              #'my/delete-char-or-region)
(global-set-key (kbd "<deletechar>")  #'my/delete-char-or-region)
(global-set-key [backspace]           #'my/backspace-or-region)
(global-set-key (kbd "<backspace>")   #'my/backspace-or-region)
(global-set-key (kbd "C-k")           #'my/delete-line)
(global-set-key (kbd "C-S-<backspace>") #'my/delete-whole-line)


;;; -------------------------------
;;; Duplikace radku nebo regionu
;;; -------------------------------
(defun my/duplicate-line-or-region ()
  "Kdyz je aktivni vyber, duplikuje ho za nej. Jinak duplikuje aktualni radek."
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
(global-set-key (kbd "C-c d") 'my/duplicate-line-or-region)

;;; -------------------------------
;;; Multiple cursors
;;; -------------------------------
(rc/require 'multiple-cursors)

(global-unset-key (kbd "C-,"))
(global-unset-key (kbd "C-."))
(global-unset-key (kbd "C-M-,"))
(global-unset-key (kbd "C-M-."))

(require 'multiple-cursors nil t)

(global-set-key (kbd "C-.")   #'mc/mark-next-like-this)
(global-set-key (kbd "C-,")   #'mc/mark-previous-like-this)
(global-set-key (kbd "C-M-.") #'mc/skip-to-next-like-this)
(global-set-key (kbd "C-M-,") #'mc/skip-to-previous-like-this)
(global-set-key (kbd "C-c C-,") #'mc/mark-all-like-this)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C-S-<down>") #'mc/mark-next-like-this)
(global-set-key (kbd "C-S-<up>")   #'mc/mark-previous-like-this)

;;; -------------------------------
;;; CZ-friendly Undo/Redo
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
;;; Zabij vsechny ostatni buffery
;;; -------------------------------
(defun my/kill-other-buffers ()
  "Zabij vsechny buffery krome aktualniho."
  (interactive)
  (mapc #'kill-buffer (delq (current-buffer) (buffer-list))))

(global-set-key (kbd "C-x K") #'kill-buffer-and-window)
(global-set-key (kbd "C-x k") #'delete-window)

;;; -------------------------------
;;; Prepinani oken
;;; -------------------------------
(when (display-graphic-p)
  (global-set-key (kbd "<C-tab>") #'other-window)
  (global-set-key (kbd "<C-S-iso-lefttab>")
                  (lambda () (interactive) (other-window -1)))
  (global-set-key (kbd "<C-S-tab>")
                  (lambda () (interactive) (other-window -1))))

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
;;; TAB/Shift-TAB na oznaceny text
;;; -------------------------------
(defun my/indent-region-or-tab ()
  "Kdyz je aktivni vyber, odsadi vybrane radky o `tab-width`. Jinak standardni Tab."
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
  "Kdyz je aktivni vyber, uber odsazeni vybranych radku o `tab-width`."
  (interactive)
  (when (use-region-p)
    (let* ((deactivate-mark nil)
           (rb (save-excursion (goto-char (region-beginning))
                               (line-beginning-position)))
           (re (save-excursion (goto-char (region-end))
                               (line-end-position))))
      (indent-rigidly rb re (- tab-width)))))

(global-set-key (kbd "<tab>") #'my/indent-region-or-tab)
(global-set-key (kbd "<backtab>") #'my/outdent-region)
(global-set-key (kbd "<S-tab>") #'my/outdent-region)
(global-set-key (kbd "<S-iso-lefttab>") #'my/outdent-region)


;;; -------------------------------
;;; Window management
;;; -------------------------------

(require 'windmove)
(require 'winner)

(winner-mode 1)

;;; Rychly pohyb mezi windows
;;
;; winner-mode standardne pouziva C-c <left>/<right>,
;; proto bindujeme primo jeho keymapu.
(define-key winner-mode-map (kbd "C-c <left>")  #'windmove-left)
(define-key winner-mode-map (kbd "C-c C-<left>")  #'windmove-left)

(define-key winner-mode-map (kbd "C-c <right>") #'windmove-right)
(define-key winner-mode-map (kbd "C-c C-<right>") #'windmove-right)

(define-key winner-mode-map (kbd "C-c <up>")    #'windmove-up)
(define-key winner-mode-map (kbd "C-c C-<up>")    #'windmove-up)

(define-key winner-mode-map (kbd "C-c <down>")  #'windmove-down)
(define-key winner-mode-map (kbd "C-c C-<down>")  #'windmove-down)


;;; Ostatni window operace
(define-prefix-command 'my/window-map)
(global-set-key (kbd "C-c w") 'my/window-map)

;; Prohod aktualni window se sousednim
(define-key my/window-map (kbd "<left>")  #'windmove-swap-states-left)
(define-key my/window-map (kbd "<right>") #'windmove-swap-states-right)
(define-key my/window-map (kbd "<up>")    #'windmove-swap-states-up)
(define-key my/window-map (kbd "<down>")  #'windmove-swap-states-down)

;; Smaz sousedni window
(define-prefix-command 'my/window-delete-map)
(define-key my/window-map (kbd "d") 'my/window-delete-map)

(define-key my/window-delete-map (kbd "<left>")  #'windmove-delete-left)
(define-key my/window-delete-map (kbd "<right>") #'windmove-delete-right)
(define-key my/window-delete-map (kbd "<up>")    #'windmove-delete-up)
(define-key my/window-delete-map (kbd "<down>")  #'windmove-delete-down)

;; Winner historie
(define-key my/window-map (kbd "u") #'winner-undo)
(define-key my/window-map (kbd "r") #'winner-redo)

;; Vyrovnej velikosti
(define-key my/window-map (kbd "=") #'balance-windows)


;;; Maximalizace aktualniho window
(defvar my/window-maximize-configuration nil)

(defun my/toggle-maximize-window ()
  "Maximalizuj aktualni window, nebo obnov puvodni layout."
  (interactive)
  (if my/window-maximize-configuration
      (let ((config my/window-maximize-configuration))
        (setq my/window-maximize-configuration nil)
        (set-window-configuration config))
    (setq my/window-maximize-configuration
          (current-window-configuration))
    (delete-other-windows)))

(define-key my/window-map (kbd "m") #'my/toggle-maximize-window)

;; Nové window horizontálně
(global-set-key (kbd "C-x ě") #'split-window-below)

;; Nové window vertikálně
(global-set-key (kbd "C-x š") #'split-window-right)


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

;;; -------------------------------
;;; Yasnippet
;;; -------------------------------
(rc/require 'yasnippet)
(when (fboundp 'yas-global-mode)
  (setq yas/triggers-in-field nil
        yas-snippet-dirs '("~/.emacs.snippets/"))
  (yas-global-mode 1))

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
(when (fboundp 'powershell-mode)
  (add-to-list 'auto-mode-alist '("\\.ps1\\'" . powershell-mode))
  (add-to-list 'auto-mode-alist '("\\.psm1\\'" . powershell-mode)))

;;; -------------------------------
;;; Eldoc
;;; -------------------------------
(add-hook 'emacs-lisp-mode-hook (lambda () (eldoc-mode 1)))

;;; -------------------------------
;;; Company (globalne), vypnout v tuareg
;;; -------------------------------
(rc/require 'company)
(when (fboundp 'global-company-mode)
  (global-company-mode)
  (add-hook 'tuareg-mode-hook (lambda () (company-mode 0))))

;;; -------------------------------
;;; TypeScript + Tide + Flycheck
;;; -------------------------------
(rc/require 'typescript-mode 'tide 'flycheck)
(defun rc/turn-on-tide-and-flycheck ()
  (when (fboundp 'tide-setup)
    (tide-setup))
  (when (fboundp 'flycheck-mode)
    (flycheck-mode 1)))
(add-hook 'typescript-mode-hook 'rc/turn-on-tide-and-flycheck)
(when (fboundp 'typescript-mode)
  (add-to-list 'auto-mode-alist '("\\.mts\\'" . typescript-mode)))

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
;;; Nacti custom-file, pokud existuje
;;; -------------------------------
(when (file-readable-p custom-file)
  (ignore-errors (load custom-file nil 'nomessage)))

;;; -------------------------------
;;; Sipky pro prochazeni souboru
;;; -------------------------------

;; HELM (helm-find-files): vlevo = o adresar vys, vpravo = otevrit/persist-action
(with-eval-after-load 'helm-files
  (define-key helm-find-files-map (kbd "<left>")
    (if (fboundp 'helm-find-files-up-one-level)
        'helm-find-files-up-one-level
      'helm-ff-run-up-one-level))
  (define-key helm-find-files-map (kbd "<right>") 'helm-execute-persistent-action)
  (define-key helm-read-file-map (kbd "<left>")
    (if (fboundp 'helm-find-files-up-one-level)
        'helm-find-files-up-one-level
      'helm-ff-run-up-one-level))
  (define-key helm-read-file-map (kbd "<right>") 'helm-execute-persistent-action))

;; DIRED: vlevo = o adresar vys, vpravo = otevrit/vstoupit
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "<left>")  'dired-up-directory)
  (define-key dired-mode-map (kbd "<right>") 'dired-find-file))

;; IDO: vlevo = o adresar vys, vpravo = potvrdit vyber
(with-eval-after-load 'ido
  (define-key ido-file-completion-map (kbd "<left>") 'ido-delete-backward-updir)
  (define-key ido-file-completion-map (kbd "<right>") 'ido-exit-minibuffer))

;;; -------------------------------
;;; Fix nil faces po startu
;;; -------------------------------
(add-hook 'emacs-startup-hook #'rc/fix-nil-faces)

;;; -------------------------------
;;; Latte a Vue pres web-mode + Eglot
;;; -------------------------------
;; web-mode uz je v balickach (viz packages-to-install)

;; Latte (.latte)
(when (fboundp 'web-mode)
  (add-to-list 'auto-mode-alist '("\\.latte\\'" . web-mode)))

(with-eval-after-load 'web-mode
  ;; Latte engine "smarty"
  (setq web-mode-engines-alist
        (append web-mode-engines-alist
                '(("smarty" . "\\.latte\\'"))))

  ;; obecne odsazeni
  (setq web-mode-markup-indent-offset 2
        web-mode-code-indent-offset   2
        web-mode-css-indent-offset    2
        web-mode-enable-auto-pairing t
        web-mode-enable-css-colorization t))

(defun my/latte-extra-font-lock ()
  "Pridat par Latte klicovych slov navic."
  (when (and buffer-file-name (string-match-p "\\.latte\\'" buffer-file-name))
    (font-lock-add-keywords
     nil
     '(("{/?\\(block\\|if\\|else\\|elseif\\|foreach\\|include\\|layout\\|var\\|define\\)\\b"
        0 font-lock-keyword-face t)))))

(add-hook 'web-mode-hook #'my/latte-extra-font-lock)

;; Vue (.vue) pres web-mode
(when (fboundp 'web-mode)
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode)))

(with-eval-after-load 'web-mode
  (add-to-list 'web-mode-engines-alist '("vue" . "\\.vue\\'"))
  (setq web-mode-script-padding 0
        web-mode-style-padding  0))

;; Eglot pro Vue
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((web-mode :language-id "vue")
                 . ("vue-language-server" "--stdio"))))

(add-hook 'web-mode-hook
          (lambda ()
            (when (and (fboundp 'eglot-ensure)
                       buffer-file-name
                       (string-match-p "\\.vue\\'" buffer-file-name))
              (eglot-ensure))))

;;; -------------------------------
;;; Markdown extra
;;; -------------------------------
(when (fboundp 'gfm-mode)
  (add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode)))

(setq markdown-command "pandoc -f gfm -t html5")

(with-eval-after-load 'markdown-mode
  (define-key markdown-mode-map (kbd "C-c p") #'markdown-live-preview-mode))

;;; -------------------------------
;;; Autosave pri prepnuti bufferu
;;; -------------------------------
(defvar my/prev-buffer nil)

(defun my/can-auto-save-p ()
  (and (buffer-modified-p)
       (buffer-file-name)
       (not buffer-read-only)
       (file-writable-p (buffer-file-name))
       (not (minibufferp))
       ;; pripadne povol TRAMP:
       (not (file-remote-p (buffer-file-name)))))

(add-hook 'pre-command-hook
          (lambda ()
            (setq my/prev-buffer (current-buffer))))

(add-hook 'post-command-hook
          (lambda ()
            (when (and my/prev-buffer
                       (buffer-live-p my/prev-buffer)
                       (not (eq my/prev-buffer (current-buffer))))
              (with-current-buffer my/prev-buffer
                (when (my/can-auto-save-p)
                  (save-buffer))))
            (setq my/prev-buffer (current-buffer))))


(defun my/create-or-refresh-etags ()
  "Vytvori nebo refreshne TAGS soubor pro aktualni projekt."
  (interactive)
  (let* ((root (or (and (fboundp 'projectile-project-root)
                        (ignore-errors (projectile-project-root)))
                   default-directory))
         (default-directory root))
    (shell-command
     "find . -type f \\( -name '*.c' -o -name '*.h' -o -name '*.cpp' -o -name '*.py' -o -name '*.el' \\) | etags -")
    (visit-tags-table (concat root "TAGS"))))

(global-set-key (kbd "C-x e") #'my/create-or-refresh-etags)

;; Vypnout org-capture na C-c c
(global-unset-key (kbd "C-c c"))
