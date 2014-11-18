(prelude-require-packages '(switch-window maxframe yasnippet paredit rainbow-delimiters))

;; Enable fancy window switching.
(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

;; Maxmize the window and start with 50/50 vertical split.
(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)
(add-hook 'window-setup-hook 'split-window-horizontally)

;; Enable yasnippet for fancy templates.
(require 'yasnippet)
(yas-global-mode t)
(yas/load-directory (expand-file-name "elpa/yasnippet-20141117.327/snippets" prelude-dir))
(yas/load-directory (expand-file-name "personal/snippets" prelude-dir))

;; Flycheck is annoying.
;; Maybe I'll get it setup to not be at some point.
;; This can't go in the preload file as it won't be defined until later.
(global-flycheck-mode -1)

;; C mode specific stuff.
(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Make these patterns more evident in code.
            (font-lock-add-keywords nil '(("\\<\\(FIXME\\|TODO\\|BUG\\|NOTE\\):" 1 font-lock-warning-face t)))
            ;; Handy for jumping between .h and .cpp files.
            (local-set-key  (kbd "C-c o") 'ff-find-other-file)))

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
            (rainbow-delimiters-mode)
            (paredit-mode 1)))
