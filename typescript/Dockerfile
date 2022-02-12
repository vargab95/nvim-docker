FROM vargab95/nvim-base

USER root

RUN pacman --noconfirm -Syu npm
RUN npm install -g typescript prettier eslint

USER developer

COPY ./config/language_specific.vim /home/developer/.config/nvim/language_specific.vim
