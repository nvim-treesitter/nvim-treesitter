curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz | tar -xz
sudo ln -s $(pwd)/nvim-osx64/bin/nvim /usr/local/bin
mkdir -p ~/.local/share/nvim/site/pack/nvim-treesitter/start
ln -s $(pwd) ~/.local/share/nvim/site/pack/nvim-treesitter/start

