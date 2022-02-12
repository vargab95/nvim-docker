#!/bin/bash

LANGUAGES=(`find ./* -maxdepth 0 -type d -not -name nvim -printf "%f\n"`)

function print_help {
    echo "$0 <base|language|all|help> [--push]"
    echo
    echo "Supported language are"
    for language in ${LANGUAGES[@]}
    do
        echo "    - $language"
    done
}

function build {
    DIRECTORY=$1
    IMAGE_NAME=$2

    docker image build -t $IMAGE_NAME $DIRECTORY

    if [[ "$PUSH" == "--push" ]]; then
        push $DIRECTORY $IMAGE_NAME
    fi
}

function push {
    DIRECTORY=$1
    IMAGE_NAME=$2

    docker image push $IMAGE_NAME
}

if [ "$#" -lt 1 ]; then
    print_help
    exit 1
elif [ "$#" -eq 2 ]; then
    if [[ "$2" != "--push" ]]; then
        print_help
        exit 2
    fi
elif [ "$#" -gt 2 ]; then
    print_help
    exit 3
fi

PUSH=$2

case $1 in
    "all")
        build nvim vargab95/nvim
        for language in "${LANGUAGES[@]}"
        do
            build $language vargab95/nvim-$language
        done
        ;;
    "base")
        build nvim vargab95/nvim
        ;;
    "help")
        print_help
        ;;
    *)
        language=$1

        declare -A language_map_helper
        for key in "${!LANGUAGES[@]}"
        do
            language_map_helper[${LANGUAGES[$key]}]="$key"
        done

        if [[ -n "${language_map_helper[$language]}" ]]
        then
            build $language vargab95/nvim-$language
        else
            echo "Not supported language"
        fi
        ;;
esac
