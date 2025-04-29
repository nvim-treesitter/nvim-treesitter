#!/bin/bash

set -e

NVIM_TAG=${NVIM_TAG-nightly}

os=$(uname -s)
if [[ $os == Linux ]]; then
  wget "https://github.com/neovim/neovim/releases/download/${NVIM_TAG}/nvim-linux-x86_64.tar.gz"
  tar -zxf nvim-linux-x86_64.tar.gz
  sudo ln -s "$PWD"/nvim-linux-x86_64/bin/nvim /usr/local/bin
  rm -rf "$PWD"/nvim-linu-x86_x64/lib/nvim/parser
elif [[ $os == Darwin ]]; then
  RELEASE_NAME="nvim-macos-$(uname -m)"
  curl -L "https://github.com/neovim/neovim/releases/download/${NVIM_TAG}/$RELEASE_NAME.tar.gz" | tar -xz
  sudo ln -s "$PWD/$RELEASE_NAME/bin/nvim" /usr/local/bin
  rm -rf "$PWD/$RELEASE_NAME/lib/nvim/parser"
else
  curl -L "https://github.com/neovim/neovim/releases/download/${NVIM_TAG}/nvim-win64.zip" -o nvim-win64.zip
  unzip nvim-win64
fi
