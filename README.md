# dotfiles
My personal configuration files for various programs I happen to use.

For now these programs include:
- emacs
- rxvt-unicode
- bspwm
- zsh
- sxhkd
- cargo
- racer

## Installation
To install the dotfiles start by cloning the repository somewhere.
```shell
$ git clone https://github.com/dogamak/dotfiles.git
```
Creating symlinks and doing additional configuration is handled by the `bootstrap.sh` script. It will create symlinks to the dotfiles provided in the repo into your home directory.
Additionally emacs packages listed in `emacs/install-packages.el` are installed or updated.
In case there is a conflict with the filed already existing in your system and the ones provded by this repo,
the script will ask how to deal with them. In these cases the script can either skip, overwrite or backup the already existing files.
