#!/usr/bin/env bash

set -e

find . -name "*.vim" -type f | grep -v "cache.vim" | while read filename; do vint -e "$filename"; done

shellcheck *.sh

./install.sh
