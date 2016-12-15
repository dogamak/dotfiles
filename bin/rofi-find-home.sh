#!/usr/bin/zsh

. $HOME/.dotfile_path

if [[ "$1" == "-" ]]
then # Called from sxhkd
    rofi -show fb -modi fb:$DOTFILES_ROOT/bin/rofi-find-home.sh -regex
else # Called from rofi
    if [[ "$#" -eq 0 ]]
    then
	find "$HOME"
    else
	coproc ( xdg-open "$@" > /dev/null 2>&1 )
	exit 0
    fi
fi
