;; My .emacs
(load "~/.emacs.d/packages/nxhtml/autostart.el")

;; Local emacs dir
  (add-to-list 'load-path "~/.emacs.d/")

;; Basic
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (blink-cursor-mode 0)
  (setq visible-bell 1)
  (setf inhibit-splash-screen 1)
  ; Make emacs use clipboard
  (setq x-select-enable-clipboard 1)
  ; "y or n" instead of "yes or no"
  (fset 'yes-or-no-p 'y-or-n-p)
  ; highlight regions and add special behaviors to regions.
  ; "C-h d transient" for more info
  (setq transient-mark-mode t)
  ; display line and column numbers
  (setq line-number-mode 1)
  (setq column-number-mode 1)
  ; remove scroll bars
  (when (fboundp 'toggle-scroll-bar)
    (toggle-scroll-bar -1))
  ; line-wrapping
  (set-default 'fill-column 80)
  ; Backup dirs
  (setq backup-directory-alist
        `((".*" . ,"~/.emacs.d/backups")))
  (setq auto-save-file-name-transforms
        `((".*" ,"~/.emacs.d/autosaves" t)))
  ; get rid of all the foo~ files it leaves lying about
  (setq make-backup-files nil)
  ; matching parens
  (show-paren-mode 1)
  ; turn on font-lock mode
  (global-font-lock-mode 1)
  ; Indentation
  (setq c-basic-offset 2)
  ; Fix some scrolling issues
  (setq scroll-conservatively 10000)
  (setq auto-window-vscroll nil)

;; Font definition
;(set-default-font "-gohu-gohufont-medium-*-*-*-11-*-*-*-*-*-*-*")

;; Package manager
  (when (>= emacs-major-version 24)
    (require 'package)
    (package-initialize)
    (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
    )

;; IDO Filebrowsing
   (require 'ido)
     (ido-mode 1)

;; ErgoEmacs
   (ergoemacs-mode 1)

;; Color Theme
  (require 'color-theme)    
    (color-theme-initialize)
    (load-theme 'solarized-dark 1)
    ;(load "~/.emacs.d/themes/color-theme-molokai.el")
    ;(color-theme-molokai)

;; Hilight 
  (global-hl-line-mode 1)

;; Auto modes
(setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))


(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
                  (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)


;;nxhtml
;; Workaround the annoying warnings:
;;    Warning (mumamo-per-buffer-local-vars):
;;    Already 'permanent-local t: buffer-file-name
(when (and (>= emacs-major-version 24)
           (>= emacs-minor-version 2))
  (eval-after-load "mumamo"
    '(setq mumamo-per-buffer-local-vars
           (delq 'buffer-file-name mumamo-per-buffer-local-vars))))
;;(autoload 'php-mode "php-mode" "Major mode for editing php code." t)

;; sml-mode
(require 'sml-mode)
(setq auto-mode-alist (cons '("\\.sml$" . sml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.sig$" . sml-mode) auto-mode-alist))
(add-hook 'sml-mode-hook 
          (lambda() ;;; *** SML-mode Customization 
            (setq sml-program-name "/opt/mosml/bin/mosml")
            (setq sml-default-arg "-P full")
            (setq sml-indent-level 2)        ; conserve on horizontal space
            (setq words-include-escape t)    ; \ loses word break status
            (setq indent-tabs-mode nil)))    ; never ever indent with tabs

;; Actionscript mode ( i dont really write actionscript these days )
;;(require 'actionscript-mode)
;;(setq auto-mode-alist (cons '("\\.as$" . actionscript-mode) auto-mode-alist))

;; Clojure
(eval-after-load 'clojure-mode
  '(progn
     (defun prelude-clojure-mode-defaults ()
       (subword-mode +1)
       (clojure-test-mode +1)
       (run-hooks 'prelude-lisp-coding-hook))

     (setq prelude-clojure-mode-hook 'prelude-clojure-mode-defaults)

     (add-hook 'clojure-mode-hook (lambda ()
                                    (run-hooks 'prelude-clojure-mode-hook)))))

(eval-after-load 'nrepl
  '(progn
     (add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)

     (defun prelude-nrepl-mode-defaults ()
       (subword-mode +1)
       (run-hooks 'prelude-interactive-lisp-coding-hook))

     (setq prelude-nrepl-mode-hook 'prelude-nrepl-mode-defaults)

     (add-hook 'nrepl-mode-hook (lambda ()
                                  (run-hooks 'prelude-nrepl-mode-hook)))))


;; Refresh 
(defun refresh-file ()
  (interactive)
  (revert-buffer t t t)
  )
(global-set-key [f5] 'refresh-file)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ergoemacs-mode-used "5.8.0")
 '(ergoemacs-theme nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mumamo-background-chunk-major ((t nil)))
 '(mumamo-background-chunk-submode1 ((t (:background "gray5")))))
