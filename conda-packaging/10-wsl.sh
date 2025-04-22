#!/bin/bash

sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install wget

wget https://repo.anaconda.com/miniconda/Miniconda3-py312_25.1.1-2-Linux-x86_64.sh

echo "4766d85b5f7d235ce250e998ebb5a8a8210cbd4f2b0fea4d2177b3ed9ea87884 Miniconda3-py312_25.1.1-2-Linux-x86_64.sh" | sha256sum -c

https://kontext.tech/article/1064/install-miniconda-and-anaconda-on-wsl-2-or-linux