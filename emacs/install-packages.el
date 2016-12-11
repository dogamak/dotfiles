(require 'package)
(package-initialize)

(setq dotfiles-package-list
      '(
	company
	racer
	rust-mode
	solarized-theme
	toml-mode
	))

(package-refresh-contents)
(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      dotfiles-package-list)
(save-buffers-kill-emacs)
