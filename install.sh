#!/bin/sh
# Highly inspired from sontek (John Anderson) dotfiles

if [ ! -d ~/.vimundo ] ; then
    mkdir ~/.vimundo
fi

link_file () {
    source="${1}"
    target="${2}"

    if [ "$(readlink -f ${target})" = "$(readlink -f ${source})" ] ; then
        # file already patched, skip
        return
    fi

    if [ -e "${target}" ]; then
        mv $target $target.bak
    fi

    ln -sf ${source} ${target}
}

link_home () {
    source="${PWD}/$1"
    target="$(echo ${HOME}/${1} | tr '_' '.')"
    link_file "${source}" "${target}"
}

if [ "$1" = "vim" ]; then
    for i in _vim*
    do
       link_home $i
    done
else
    for i in _*
    do
        link_home $i
    done
fi

link_file "${PWD}/dropboxpublic.desktop" "${HOME}/.kde/share/kde4/services/ServiceMenus/dropboxpublic.desktop"

git submodule sync
git submodule update --init --recursive
git submodule update --recursive

# setup command-t
cd _vim/bundle/command-t
rake make
