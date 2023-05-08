if vim.g.loaded_nvim_treesitter then
  return
end
vim.g.loaded_nvim_treesitter = true

local api = vim.api

-- define autocommands
local augroup = api.nvim_create_augroup('nvim-treesitter', {})

api.nvim_create_autocmd('Filetype', {
  pattern = 'query',
  group = augroup,
  callback = function()
    api.nvim_clear_autocmds({
      group = augroup,
      event = 'BufWritePost',
    })
    api.nvim_create_autocmd('BufWritePost', {
      group = augroup,
      buffer = 0,
      callback = function(opts)
        require('nvim-treesitter.query').invalidate_query_file(opts.file)
      end,
      desc = 'Invalidate query file',
    })
  end,
  desc = 'Reload query',
})

-- create user commands
api.nvim_create_user_command('TSInstallInfo', function()
  require('nvim-treesitter.info').install_info()
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
    end, require('nvim-treesitter.parsers').available_parsers())
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
    end, require('nvim-treesitter.parsers').available_parsers())
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
    end, require('nvim-treesitter.parsers').available_parsers())
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
    end, require('nvim-treesitter.info').installed_parsers())
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
    end, require('nvim-treesitter.info').installed_parsers())
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
    end, require('nvim-treesitter.info').installed_parsers())
  end,
  desc = 'Uninstall treesitter parsers',
})
