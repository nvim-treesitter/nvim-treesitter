local fn = vim.fn

local M = {}

function M.check()
  vim.health.start('Installation')

  if fn.executable('curl') == 1 then
    local handle = io.popen('curl --version')
    if handle then
      local result = handle:read('*a')
      handle:close()
      local version = vim.split(result, '\n')[1]
      vim.health.ok('`cURL` is installed, version: ' .. (version or 'unknown'))
    else
      vim.health.error('`cURL` is installed but cannot be executed')
    end
  else
    vim.health.error('`cURL` is not installed')
  end
end

return M
