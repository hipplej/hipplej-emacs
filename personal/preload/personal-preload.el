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

;; Configure default buffer settings.
(setq-default buffer-file-coding-system 'utf-8
              tab-width 4
              indent-tabs-mode nil
              fill-column 100)

;; Don't prompt me when killing buffers with active processes.
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))

;; Always show line numbers.
(global-linum-mode t)

;; Set the color theme.
(add-to-list 'custom-theme-load-path (expand-file-name "themes" prelude-personal-dir))
(setq prelude-theme 'base16-default-dark)

;; Turn off scroll bars.
(scroll-bar-mode -1)

;; Disable the audible bell.
(setq visible-bell t)

;; Close Emacs with confirmation.
(defun confirm-exit-from-emacs ()
  (interactive)
  (if (yes-or-no-p "Do you want to exit? ")
      (save-buffers-kill-emacs)))
(global-set-key (kbd "C-x C-c") 'confirm-exit-from-emacs)

;; Disable suspend. I never use it on purpose.
(global-unset-key (kbd "C-z"))

;; You can actually use a real terminal from within Emacs on Linux once the
;; PATH environment variable is set correctly.
;; Also make sure that we use a colorized prompt.
(if using-linux-p
    (progn
      (setenv "PATH" (concat (getenv "PATH") ":~/bin"))
      (setenv "color_prompt" "yes")
      (setq exec-path (append exec-path '("~/bin")))))

;; A handy function for starting a shell buffer in a new window or visiting
;; an existing shell buffer. Uses eshell on Windows, ansi-term everywhere else.
(defun start-shell ()
  (interactive)
  (let ((shell-buffer-name (if using-windows-p "*eshell*" "*ansi-term*")))
    (if (not (get-buffer shell-buffer-name))
        (progn
          (split-window-sensibly (selected-window))
          (other-window 1)
          (if using-windows-p (eshell) (ansi-term (getenv "SHELL"))))
      (switch-to-buffer-other-window shell-buffer-name))))
(global-set-key (kbd "<f5>") 'start-shell)

;; Disable fuzzy matching on Windows since it seems to be slow for some reason.
(setq helm-projectile-fuzzy-match (not using-windows-p))

;; FIXME: This needs to be removed after upgrading to emacs 25.
;; I had to add it to make loading recentf not take forever.
;; See https://github.com/bbatsov/prelude/issues/896
(setq tramp-ssh-controlmaster-options)
