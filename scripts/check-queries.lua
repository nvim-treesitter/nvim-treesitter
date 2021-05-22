-- Execute as `nvim --headless -c "luafile ./scripts/check-queries.lua"`

local function extract_captures()
  local lines = vim.fn.readfile("CONTRIBUTING.md")
  local captures = {}
  local current_query

  for _, line in ipairs(lines) do
    if vim.startswith(line, "### ") then
      current_query = vim.fn.tolower(line:sub(5))
    elseif vim.startswith(line, "@") and current_query then
      if not captures[current_query] then
        captures[current_query] = {}
      end

      table.insert(captures[current_query], vim.split(line:sub(2), " ", true)[1])
    end
  end

  -- Complete captures for injections.
  local parsers = require 'nvim-treesitter.info'.installed_parsers()
  for _, lang in pairs(parsers) do
    table.insert(captures['injections'], lang)
  end

  return captures
end

local function do_check()
  local parsers = require 'nvim-treesitter.info'.installed_parsers()
  local queries = require 'nvim-treesitter.query'
  local query_types = queries.built_in_query_groups

  local captures = extract_captures()
  local last_error

  for _, lang in pairs(parsers) do
    for _, query_type in pairs(query_types) do
      print('Checking '..lang..' '..query_type)
      local ok, query = pcall(queries.get_query, lang, query_type)
      if not ok then
        vim.api.nvim_err_writeln(query)
        last_error = query
      else
        if query then
          for _, capture in ipairs(query.captures) do
            local is_valid = (
              vim.startswith(capture, "_")  -- Helpers.
              or vim.tbl_contains(captures[query_type], capture)
            )
            if not is_valid then
              local error = string.format("(x) Invalid capture @%s in %s for %s.", capture, query_type, lang)
              print(error)
              last_error = error
            end
          end
        end
      end
    end
  end
  if last_error then
    print()
    print("Last error: ")
    error(last_error)
  end
end


local ok, err = pcall(do_check)
local allowed_to_fail = vim.split(vim.env.ALLOWED_INSTALLATION_FAILURES or '', ",", true)

for k, v in pairs(require 'nvim-treesitter.parsers'.get_parser_configs()) do
  if not require 'nvim-treesitter.parsers'.has_parser(k) then
    -- On CI all parsers that can be installed from C files should be installed
    if vim.env.CI
      and not v.install_info.requires_generate_from_grammar
      and not vim.tbl_contains(allowed_to_fail, k) then

      print('Error: parser for '..k..' is not installed')
      vim.cmd('cq')
    else
      print('Warning: parser for '..k..' is not installed')
    end
  end
end

if ok then
  print('Check successful!\n')
  vim.cmd('q')
else
  print('Check failed:')
  print(err)
  print('\n')
  vim.cmd('cq')
end
