choco install neovim --pre
mkdir -p ~/AppData/Local/nvim/pack/nvim-treesitter/start
mkdir -p ~/AppData/Local/nvim-data
cp -r $(pwd) ~/AppData/Local/nvim/pack/nvim-treesitter/start
C:\\tools\\neovim\\Neovim\\bin\\nvim.exe --headless -c "TSInstall all" -c "sleep 120" -c "q"
cp -r ~/AppData/Local/nvim/pack/nvim-treesitter/start/nvim-treesitter/parser/* parser
