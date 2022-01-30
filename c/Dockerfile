FROM vargab95/nvim

USER root

RUN apt-get install -y clang-tidy clang-format

USER developer

COPY ./config/language_specific.vim /home/developer/.config/nvim/language_specific.vim
