# NVIM Docker

A simple, fast dockerized neovim editor.

## Configuration

Add the following function to $HOME/.bashrc file.
```bash
function ddev {
    local language=$1
    shift
    docker container run --rm -it $@ -v `pwd`:/home/developer/workspace vargab95/nvim-$language
}
```

A new bash function will be available which allows to start a dockerized
development environment for the supported languages.
```bash
ddev python
```

Furthermore, it allows to specify any additional docker command line parameters.
```bash
ddev python -p 8080:8080
```

## Build

Docker images can be built locally using the following bash script.

```bash
./build.sh all
```

For specific language builds, print the help.
```bash
./build.sh help
```
