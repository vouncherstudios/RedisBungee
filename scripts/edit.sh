#!/usr/bin/env bash

pushd RedisBungee-Plugin
git rebase --interactive upstream/upstream
popd
