#!/usr/bin/env bash

sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt-get update
sudo apt-get install shellcheck python3.6 -y
sudo pip install vim-vint pathlib typing enum34
