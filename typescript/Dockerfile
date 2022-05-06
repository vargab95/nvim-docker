FROM vargab95/nvim-base

USER root

RUN pacman --noconfirm -Syu npm
RUN npm install -g typescript typescript-language-server neovim prettier eslint

USER developer

COPY ./config/language_specific.lua /home/developer/.config/nvim/lua/language_specific.lua

RUN nvim --headless -c "TSInstall javascript typescript" -c "sleep 10" -c qa
