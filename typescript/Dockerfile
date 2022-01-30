FROM vargab95/nvim

USER root

RUN curl -fsSL https://deb.nodesource.com/setup_17.x | bash - && apt-get install -y nodejs
RUN npm install -g prettier eslint

USER developer

COPY ./config/language_specific.vim /home/developer/.config/nvim/language_specific.vim
