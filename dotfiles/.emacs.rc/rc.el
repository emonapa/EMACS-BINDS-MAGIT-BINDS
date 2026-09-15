(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(defvar rc/auto-install-packages t)
(defvar rc/package-installation-available rc/auto-install-packages)
(defvar rc/package-contents-refreshed nil)

(defun rc/package-refresh-contents-once ()
  (when (and rc/package-installation-available
             (not rc/package-contents-refreshed))
    (setq rc/package-contents-refreshed t)
    (condition-case err
        (package-refresh-contents)
      (error
       (setq rc/package-installation-available nil)
       (message "Package archives nejsou dostupne: %s"
                (error-message-string err))))))

(defun rc/require-one-package (package)
  (when (and rc/package-installation-available
             (not (package-installed-p package)))
    (rc/package-refresh-contents-once)
    (when rc/package-installation-available
      (condition-case err
          (package-install package)
        (error
         (message "Balicek %s nelze nainstalovat: %s"
                  package (error-message-string err)))))))

(defun rc/require (&rest packages)
  (dolist (package packages)
    (rc/require-one-package package)))

(defun rc/require-theme (theme)
  (let ((theme-package (intern (format "%s-theme" theme))))
    (rc/require theme-package)
    (load-theme theme t)))

(rc/require 'dash)
(require 'dash nil t)

(rc/require 'dash-functional)
(require 'dash-functional nil t)
