(require 'package)

;; It would be nice to have these loaded from ~/.emacs.d/init.el
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("maramalade" . "https://marmalade-repo.org/packages/"))
;; 
(package-initialize)

(setq dotfiles-package-list
      '(
	cargo
	company
	evil
	helm
	helm-projectile
	magit
	projectile
	racer
	rust-mode
	solarized-theme
	toml-mode
	))

(package-refresh-contents)
(dolist (package dotfiles-package-list)
  (unless (package-installed-p package)
    (package-install package)))

