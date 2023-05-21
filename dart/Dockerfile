FROM vargab95/nvim-base

USER root

RUN pacman --noconfirm -Syu dart

USER developer

COPY ./config/language_specific.lua /home/developer/.config/nvim/lua/language_specific.lua

RUN nvim --headless -c "TSInstall dart" -c "sleep 10" -c qa
