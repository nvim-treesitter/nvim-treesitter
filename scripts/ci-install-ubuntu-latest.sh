sudo apt-get update
sudo add-apt-repository universe
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
mkdir -p ~/.local/share/nvim/site/pack/nvim-treesitter/start
ln -s $(pwd) ~/.local/share/nvim/site/pack/nvim-treesitter/start
sudo cp ./nvim.appimage /usr/bin/nvim
sudo chmod uog+rwx /usr/bin/nvim

