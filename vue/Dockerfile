FROM vargab95/nvim-typescript

USER root

RUN npm install -g vls

USER developer

COPY ./config/language_specific.lua /home/developer/.config/nvim/lua/language_specific.lua

RUN nvim --headless -c "TSInstall vue" -c "sleep 10" -c qa
