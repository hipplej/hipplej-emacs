;; Determine where I'm probably working based on the type of system I'm using.
(defvar using-windows-p (eq system-type 'windows-nt))
(defvar using-osx-p (eq system-type 'darwin))
(defvar using-linux-p (eq system-type 'gnu/linux))
(defvar office-email-address "justin.hipple@zuerchertech.com")
(defvar home-email-address "brokenreality@gmail.com")
(defvar default-font-name
  (cond (using-windows-p "Bitstream Vera Sans Mono-8")
        (using-osx-p "Bitstream Vera Sans Mono-14")
        ("Bitstream Vera Sans Mono-10")))

;; Use a decent font.
;; Evidently there are weird display issues if this is set after color theme is loaded?
;; Spawning a new frame resulted in very strange colors applied to all buffers it contained.
(add-to-list 'default-frame-alist `(font . ,default-font-name))

;; Set an appropriate email address depending on whether I'm at work or home.
;; If I'm on Windows it's because I'm doing "real work", so use my work email address.
(setq user-mail-address (if using-windows-p office-email-address home-email-address))

;; Don't show the damn splash screen.
(setq inhibit-splash-screen t)

;; Tabs cause nothing but headaches but I'm forced to use them at work.
(setq-default tab-width 4)
(setq-default indent-tabs-mode using-windows-p)

;; Typing replaces the selected region.
(delete-selection-mode t)

;; Don't prompt me when killing buffers with active processes.
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))

;; Default to 'string' mode when using re-builder.
(setq reb-re-syntax 'string)

;; Always show line numbers.
(global-linum-mode t)

;; Set the color theme.
(setq prelude-theme 'sanityinc-tomorrow-bright)

;; Disable the audible bell.
(setq visible-bell t)

;; Whitespace mode is kind of annoying.
(setq prelude-whitespace nil)

;; Flycheck is also annoying.
;; Maybe I'll get it setup to not be at some point.
(global-flycheck-mode -1)

;; Close Emacs with confirmation.
(defun confirm-exit-from-emacs ()
  (interactive)
  (if (yes-or-no-p "Do you want to exit? ")
      (save-buffers-kill-emacs)))
(global-set-key (kbd "C-x C-c") 'confirm-exit-from-emacs)
