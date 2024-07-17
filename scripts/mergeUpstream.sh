#!/usr/bin/env bash

PS1="$"
basedir=`pwd`

function update {
    cd "$basedir/$1"
    git fetch && git reset --hard origin/main
    cd "$basedir/$1/.."
    git add $1
}

function update_if_new_tags {
    cd "$basedir/$1"
    git fetch --tags

    latest_tag=$(git tag -l --sort=-creatordate | head -n 1)
    current_tag=$(git tag --points-at HEAD)

    if [ "$latest_tag" != "$current_tag" ]; then
        echo "New tag detected in $1: $latest_tag"
        git reset --hard $latest_tag
        cd "$basedir/$1/.."
        git add $1
    else
        echo "No new tags detected in $1."
    fi
}

if [ "$1" == "--tags" ]; then
    update_if_new_tags RedisBungee
else
    update RedisBungee
fi

# Update submodules
git submodule update --recursive
