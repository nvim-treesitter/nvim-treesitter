#!/bin/bash

set -e

os=$(uname -s)
if [[ $os == Linux ]]; then
  wget https://github.com/neovim/neovim/releases/download/${NVIM_TAG}/nvim-linux64.tar.gz
  tar -zxf nvim-linux64.tar.gz
  sudo ln -s "$PWD"/nvim-linux64/bin/nvim /usr/local/bin
  rm -rf "$PWD"/nvim-linux64/lib/nvim/parser
  mkdir -p ~/.local/share/nvim/site/pack/nvim-treesitter/start
  ln -s "$PWD" ~/.local/share/nvim/site/pack/nvim-treesitter/start
elif [[ $os == Darwin ]]; then
  curl -L https://github.com/neovim/neovim/releases/download/${NVIM_TAG}/nvim-macos.tar.gz | tar -xz
  sudo ln -s "$PWD"/nvim-macos/bin/nvim /usr/local/bin
  rm -rf "$PWD"/nvim-macos/lib/nvim/parser
  mkdir -p ~/.local/share/nvim/site/pack/nvim-treesitter/start
  ln -s "$PWD" ~/.local/share/nvim/site/pack/nvim-treesitter/start
else
  curl -L https://github.com/neovim/neovim/releases/download/${NVIM_TAG}/nvim-win64.zip -o nvim-win64.zip
  unzip nvim-win64
  mkdir -p ~/AppData/Local/nvim/pack/nvim-treesitter/start
  mkdir -p ~/AppData/Local/nvim-data
  cp -r "$PWD" ~/AppData/Local/nvim/pack/nvim-treesitter/start
fi
