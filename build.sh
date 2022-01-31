#!/bin/bash

LANGUAGES=(`find ./* -maxdepth 0 -type d -not -name nvim -printf "%f\n"`)

function print_help {
    echo "$0 <base|language|all|help>"
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
}

if [ "$#" -ne 1 ]; then
    print_help
    exit 0
fi

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
