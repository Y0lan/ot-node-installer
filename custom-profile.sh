#!/bin/bash

configureOhMyZSH(){
    git clone https://github.com/jotyGill/quickz-sh.git
    cd quickz-sh
    ./install.sh -c
}

configureVim(){
    git clone https://github.com/CaffeineViking/vimrc.git ~/.vim_temp && \
    cd ~/.vim_temp && \
    ./setup.sh && \
    rm -rf ~/.vim_temp && \
    cd ~
}

configureVim
configureOhMyZSH

