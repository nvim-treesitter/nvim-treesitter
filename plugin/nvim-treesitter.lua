if vim.g.loaded_nvim_treesitter then
  return
end
vim.g.loaded_nvim_treesitter = true

local api = vim.api

-- create user commands
api.nvim_create_user_command('TSInstallInfo', function()
  require('nvim-treesitter.install').info()
end, { nargs = 0, desc = 'List available treesitter parsers' })

api.nvim_create_user_command('TSInstall', function(args)
  require('nvim-treesitter.install').install({ ask_reinstall = not args.bang or 'force' })(
    args.fargs
  )
end, {
  nargs = '+',
  bang = true,
  bar = true,
  complete = function(arglead)
    return vim.iter.filter(function(v)
      return v:find(arglead)
    end, require('nvim-treesitter.parsers').get_available())
  end,
  desc = 'Install treesitter parsers',
})

api.nvim_create_user_command('TSInstallFromGrammar', function(args)
  require('nvim-treesitter.install').install({
    generate_from_grammar = true,
    ask_reinstall = not args.bang or 'force',
  })(args.fargs)
end, {
  nargs = '+',
  bang = true,
  bar = true,
  complete = function(arglead)
    return vim.iter.filter(function(v)
      return v:find(arglead)
    end, require('nvim-treesitter.parsers').get_available())
  end,
  desc = 'Install treesitter parsers from grammar',
})

api.nvim_create_user_command('TSInstallSync', function(args)
  require('nvim-treesitter.install').install({
    with_sync = true,
    ask_reinstall = not args.bang or 'force',
  })(args.fargs)
end, {
  nargs = '+',
  bang = true,
  bar = true,
  complete = function(arglead)
    return vim.iter.filter(function(v)
      return v:find(arglead)
    end, require('nvim-treesitter.parsers').get_available())
  end,
  desc = 'Install treesitter parsers synchronously',
})

api.nvim_create_user_command('TSUpdate', function(args)
  require('nvim-treesitter.install').update()(args.fargs)
end, {
  nargs = '*',
  bar = true,
  complete = function(arglead)
    return vim.iter.filter(function(v)
      return v:find(arglead)
    end, require('nvim-treesitter.install').installed_parsers())
  end,
  desc = 'Update installed treesitter parsers',
})

api.nvim_create_user_command('TSUpdateSync', function(args)
  require('nvim-treesitter.install').update({ with_sync = true })(args.fargs)
end, {
  nargs = '*',
  bar = true,
  complete = function(arglead)
    return vim.iter.filter(function(v)
      return v:find(arglead)
    end, require('nvim-treesitter.install').installed_parsers())
  end,
  desc = 'Update installed treesitter parsers synchronously',
})

api.nvim_create_user_command('TSUninstall', function(args)
  require('nvim-treesitter.install').uninstall(args.fargs)
end, {
  nargs = '+',
  bar = true,
  complete = function(arglead)
    return vim.iter.filter(function(v)
      return v:find(arglead)
    end, require('nvim-treesitter.install').installed_parsers())
  end,
  desc = 'Uninstall treesitter parsers',
})
