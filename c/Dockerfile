FROM vargab95/nvim-base

USER root

RUN pacman --noconfirm -Syu clang

USER developer

COPY ./config/language_specific.lua /home/developer/.config/nvim/lua/language_specific.lua

RUN nvim --headless -c "TSInstall c cmake" -c "sleep 10" -c qa
