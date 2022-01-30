FROM vargab95/nvim

USER root

RUN apt-get install -y python3 python3-pip && \
    python3 -m pip install pylint flake8 yapf

USER developer

COPY ./config/language_specific.vim /home/developer/.config/nvim/language_specific.vim
