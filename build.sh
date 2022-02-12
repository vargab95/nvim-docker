#!/bin/bash

VARIANTS=(`find ./* -maxdepth 0 -type d -printf "%f\n"`)

function print_help {
    echo "$0 <variant|all|help> [--push]"
    echo
    echo "Supported variants are"
    for variant in ${VARIANTS[@]}
    do
        echo "    - $variant"
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
        for variant in "${VARIANTS[@]}"
        do
            build $variant vargab95/nvim-$variant
        done
        ;;
    "help")
        print_help
        ;;
    *)
        variant=$1

        declare -A variant_map_helper
        for key in "${!VARIANTS[@]}"
        do
            variant_map_helper[${VARIANTS[$key]}]="$key"
        done

        if [[ -n "${variant_map_helper[$variant]}" ]]
        then
            build $variant vargab95/nvim-$variant
        else
            echo "Not supported variant"
        fi
        ;;
esac
