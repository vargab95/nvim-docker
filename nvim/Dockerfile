FROM debian:stable

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y neovim curl git

RUN useradd -ms /bin/bash developer

USER developer
WORKDIR /home/developer

RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

COPY ./config/* /home/developer/.config/nvim/

RUN nvim --headless +PlugInstall +qall

WORKDIR /home/developer/workspace

CMD "nvim"
