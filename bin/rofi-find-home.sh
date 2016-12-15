#!/usr/bin/zsh

. $HOME/.dotfile_path

if [[ "$#" -gt 0 ]]
then # Called from sxhkd
    xdg-open "$(rofi -show fb -modi fb:$DOTFILES_ROOT/bin/rofi-find-home.sh -regex)"
else # Called from rofi
    find "$HOME"
fi
