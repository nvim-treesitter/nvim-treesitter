choco install neovim --pre
mkdir %homedrive%%homepath%\\AppData\\Local\\nvim\\pack\\nvim-treesitter\\start
mkdir %homedrive%%homepath%\\AppData\\Local\\nvim-data
xcopy . %homedrive%%homepath%\\AppData\\Local\\nvim\\pack\\nvim-treesitter\\start\\ /E/H
