brew update
brew install llvm --HEAD
brew install neovim --HEAD
brew install tree-sitter
mkdir -p ~/.local/share/nvim/site/pack/nvim-treesitter/start
ln -s $(pwd) ~/.local/share/nvim/site/pack/nvim-treesitter/start

