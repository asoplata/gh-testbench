#!/bin/bash

# Adapted from
# https://kontext.tech/article/1064/install-miniconda-and-anaconda-on-wsl-2-or-linux

sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install wget

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

bash Miniconda3-latest-Linux-x86_64.sh



