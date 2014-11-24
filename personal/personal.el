;; Prelude will automatically install the packages specified in this list.
(prelude-require-packages '(switch-window maxframe yasnippet paredit rainbow-delimiters))

;; Enable various Prelude modules.
(require 'prelude-helm) ;; Interface for narrowing and search
(require 'prelude-helm-everywhere) ;; Enable Helm everywhere
(require 'prelude-company)
(require 'prelude-key-chord) ;; Binds useful features to key combinations
(require 'prelude-c)
(require 'prelude-clojure)
(require 'prelude-css)
(require 'prelude-emacs-lisp)
(require 'prelude-js)
(require 'prelude-python)
(require 'prelude-shell)
(require 'prelude-xml)
(require 'prelude-yaml)

;; Enable fancy window switching.
(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

;; Maxmize the window and start with 50/50 vertical split.
(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)
(add-hook 'window-setup-hook 'split-window-horizontally)

;; Enable yasnippet for fancy templates.
(require 'yasnippet)
(setq yas-snippet-dirs (expand-file-name "personal/snippets" prelude-dir))
(yas-global-mode t)

;; Provide fancy highlighting of parenthesis and related symbols.
(require 'rainbow-delimiters)
(rainbow-delimiters-mode)

;; Flycheck is annoying.
;; Maybe I'll get it setup to not be at some point.
;; This can't go in the preload file as it won't be defined until later.
(global-flycheck-mode -1)

;; Qt's .pro and .pri files use IDL mode by default, make them not do that.
;; Also make .conf files use shell script mode.
(add-to-list 'auto-mode-alist '("\\.pro\\'" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.pri\\'" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.conf\\'" . shell-script-mode))

;; Setup some handy Company mode keybinds.
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-h") 'company-show-doc-buffer)
(define-key company-active-map (kbd "<tab>") 'company-complete-selection)

;; General programming mode specific stuff.
(add-hook 'prog-mode-common-hook
          (lambda ()
            ;; Make these patterns more evident in code.
            (font-lock-add-keywords nil '(("\\<\\(FIXME\\|TODO\\|BUG\\|NOTE\\):" 1 font-lock-warning-face t)))))

;; Python mode specific stuff.
(add-hook 'python-mode-hook
          (lambda ()
            ;; Setup the style based one whether I'm at home or the office.
            (setq tab-width 4
                  py-indent-offset 4
                  indent-tabs-mode using-windows-p
                  py-smart-indentation (not using-windows-p)
                  python-indent 4)))

;; Clojure mode specific stuff.
(add-hook 'clojure-mode-hook
          (lambda ()
            (paredit-mode 1)))

;; Run as a server.
(server-start)
