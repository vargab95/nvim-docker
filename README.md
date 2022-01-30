# NVIM Docker

A simple, fast dockerized neovim editor.

## Configuration

Add the following script to $HOME/.bashrc file.
```bash
function ddev {
    local language=$1
    shift
    docker container run --rm -it $@ -v `pwd`:/home/developer/workspace vargab95/nvim-$language
}
```

With this, a new bash function will be available. It allows to start a
dockerized development environment for the supported languages.
```bash
ddev python
```

Furthermore, it allows to specify any additional docker command line switches.
```bash
ddev python -p 8080:8080
```

## Build

Docker images can be built using the following bash script.

```bash
./build.sh all
```

For specific language builds, print the help.
```bash
./build.sh help
```
