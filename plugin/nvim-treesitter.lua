if vim.g.loaded_nvim_treesitter then
  return
end
vim.g.loaded_nvim_treesitter = true

local api = vim.api

local function complete_available_parsers(arglead)
  return vim.tbl_filter(
    --- @param v string
    function(v)
      return v:find(arglead) ~= nil
    end,
    require('nvim-treesitter.config').get_available()
  )
end

local function complete_installed_parsers(arglead)
  return vim.tbl_filter(
    --- @param v string
    function(v)
      return v:find(arglead) ~= nil
    end,
    require('nvim-treesitter.config').installed_parsers()
  )
end

-- create user commands
api.nvim_create_user_command('TSInstall', function(args)
  require('nvim-treesitter.install').install(args.fargs, { force = args.bang })
end, {
  nargs = '+',
  bang = true,
  bar = true,
  complete = complete_available_parsers,
  desc = 'Install treesitter parsers',
})

api.nvim_create_user_command('TSInstallFromGrammar', function(args)
  require('nvim-treesitter.install').install(args.fargs, {
    generate = true,
    force = args.bang,
  })
end, {
  nargs = '+',
  bang = true,
  bar = true,
  complete = complete_available_parsers,
  desc = 'Install treesitter parsers from grammar',
})

api.nvim_create_user_command('TSUpdate', function(args)
  require('nvim-treesitter.install').update(args.fargs)
end, {
  nargs = '*',
  bar = true,
  complete = complete_installed_parsers,
  desc = 'Update installed treesitter parsers',
})

api.nvim_create_user_command('TSUninstall', function(args)
  require('nvim-treesitter.install').uninstall(args.fargs)
end, {
  nargs = '+',
  bar = true,
  complete = complete_installed_parsers,
  desc = 'Uninstall treesitter parsers',
})

api.nvim_create_user_command('TSLog', function()
  require('nvim-treesitter.log').show()
end, {
  desc = 'View log messages',
})
