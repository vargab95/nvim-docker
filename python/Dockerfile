FROM vargab95/nvim-base

USER root

RUN pacman --noconfirm -Syu python3 python-pip && \
    python3 -m pip install pylint flake8 yapf

USER developer

COPY ./config/language_specific.lua /home/developer/.config/nvim/lua/language_specific.lua

RUN nvim --headless -c "TSInstall python" -c "sleep 10" -c qa
