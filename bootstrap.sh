#!/usr/bin/zsh

autoload -U colors
colors

DOTFILES_ROOT="$0:A:h"

sym_link() {
    local source="$1" target="$2"

    local overwrite= backup= skip= action=
    
    if [[ -a "$source" ]]; then
	if [[ -a "$target" ]] || [[ -L "$target" ]] && [[ "$(readlink $target)" != "${source:A}" ]]; then
	    if [[ "$skip_all" == "false" ]] && [[ "$overwrite_all" == false ]] && [[ "$backup_all" == false ]]; then
		printf ">> File '$target' already exists! What do you want to do?\n";
		printf "[S]kip all, [s]kip, [O]verwrite all, [o]verwrite, [B]ackup all, [b]ackup? ";
		
		read -sk 1 action

		echo
		
		case "$action"; in
		    S)
			skip_all=true;;
		    s)
			skip=true;;
		    O)
			overwrite_all=true;;
		    o)
			overwrite=true;;
		    B)
			backup_all=true;;
		    b)
			backup=true;;
		    *)
		    ;;
		esac
	    fi
	elif [[ -L "$target" ]] && [[ "$(readlink $target)" == "${source:A}" ]]; then
	    skip=true;
	fi

	skip=${skip:-$skip_all}
	overwrite=${overwrite:-$overwrite_all}
	backup=${backup:-$backup_all}

	if [[ "$skip" == true ]]; then
	    echo "$fg[green]>> Skipping '$target'$fg[default]"
	else
	    if [[ "$backup" == "true" ]]; then
		mv "$target" "${target}.bak"
		echo "$fg[green]>> Moved '$target' to '$target.bak'$fg[default]"
	    elif [[ "$overwrite" == "true" ]]; then
		rm -rf "$target"
		echo "$fg[red]>> Deleted '$target'$fg[default]"
	    fi

	    echo "$fg[green]>> Linked '$source' to '$target'$fg[default]"
	    
	    mkdir -p "${target:h}"
	    ln -s "$source" "$target"
	fi
    else
	echo "$fg[red]ERROR: File '$source' does not exist!$fg[default]";
	exit 1
    fi
}

find . -name \*.symlink|sed 's_^./\([^/]\+\)/\(.\+\).symlink$_'$(pwd)'/\1/\2.symlink\n'$HOME'/\2_' > /tmp/symlinks;

local skip_all=false overwrite_all=false backup_all=false

exec {symlink_fd}</tmp/symlinks;

while IFS= read -r source <&$symlink_fd; do
    read -r target <&$symlink_fd;
    
    sym_link "${source}" "${target}"
done

for installer in `find $(pwd) -name 'install.sh'`; do
    installer=${installer:A}
    echo "$fg[yellow]>> Running setup script for '${installer:h:t}'$fg[default]";
    cd "${installer:h}";
    source $installer;
done
