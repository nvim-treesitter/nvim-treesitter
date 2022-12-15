local _MODREV, _SPECREV = 'scm', '-1'

rockspec_format = "3.0"
package = 'nvim_treesitter'
version = _MODREV .. _SPECREV

description = {
  summary = 'A framework for interacting with tests within NeoVim.',
  detailed = [[
    The goal of nvim-treesitter is both to provide a simple and easy way to use the interface 
    for tree-sitter in Neovim and to provide some basic functionality such as highlighting based on it.
  ]],
  homepage = 'https://github.com/nvim-treesitter/nvim-treesitter',
  license = 'Apache/2.0',
  labels = { 'neovim', 'tree-sitter', }
}

dependencies = {
  'lua == 5.1',
}

source = {
  url = 'https://github.com/nvim-treesitter/nvim-treesitter/archive/v' .. _MODREV .. '.zip',
  dir = 'nvim-treesitter-' .. _MODREV,
}

if _MODREV == 'scm' then
  source = {
    url = 'git://github.com/nvim-treesitter/nvim-treesitter',
  }
end

build = {
  type = 'builtin',
  copy_directories = {
    'doc'
  }
}
