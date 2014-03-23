#!/usr/bin/env bash
# Highly inspired from sontek (John Anderson) dotfiles

if [ ! -d ~/.vimundo ] ; then
    mkdir ~/.vimundo
fi

function link_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}" ]; then
        mv $target $target.bak
    fi

    ln -sf ${source} ${target}
}

if [ "$1" = "vim" ]; then
    for i in _vim*
    do
       link_file $i
    done
else
    for i in _*
    do
        link_file $i
    done
fi

if [ -e .kde/share/kde4/services/ServiceMenus/dropboxpublic.desktop ]; then
    mv .kde/share/kde4/services/ServiceMenus/dropboxpublic.desktop{,.bak}
fi
ln -sf ${PWD}/dropboxpublic.desktop ${HOME}.kde/share/kde4/services/ServiceMenus # FIXME: if you need this another time, do a function

git submodule sync
git submodule init
git submodule update
git submodule foreach git pull origin master
git submodule foreach git submodule init
git submodule foreach git submodule update

# setup command-t
cd _vim/bundle/command-t
rake make
