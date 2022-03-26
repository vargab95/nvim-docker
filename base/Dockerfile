FROM archlinux

RUN pacman --noconfirm -Syu neovim curl git ripgrep gcc

RUN useradd -ms /bin/bash developer

USER developer
WORKDIR /home/developer

RUN sh -c 'git clone --depth 1 https://github.com/wbthomason/packer.nvim\
           ~/.local/share/nvim/site/pack/packer/start/packer.nvim'

COPY ./config/dependencies.lua /home/developer/.config/nvim/lua/

RUN nvim --headless -c "luafile /home/developer/.config/nvim/lua/dependencies.lua" -c "PackerInstall" -c "sleep 10" -c "qa"

COPY ./config/init.lua /home/developer/.config/nvim/

WORKDIR /home/developer/workspace

CMD "nvim"
