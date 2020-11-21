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

  return captures
end

local function do_check()
  local parsers = require 'nvim-treesitter.parsers'.available_parsers()
  local queries = require 'nvim-treesitter.query'
  local query_types = queries.built_in_query_groups

  local captures = extract_captures()

  for _, lang in pairs(parsers) do
    for _, query_type in pairs(query_types) do
      print('Checking '..lang..' '..query_type)
      local query = queries.get_query(lang, query_type)

      if query then
        for _, capture in ipairs(query.captures) do
          if not vim.startswith(capture, "_") -- We ignore things like _helper
            and captures[query_type]
            and not capture:find("^[A-Z]") -- Highlight groups
            and not vim.tbl_contains(captures[query_type], capture) then
            error(string.format("Invalid capture @%s in %s for %s.", capture, query_type, lang))
          end
        end
      end
    end
  end
end


local ok, err = pcall(do_check)
if ok then
  print('Check successful!\n')
  vim.cmd('q')
else
  print('Check failed:')
  print(err)
  print('\n')
  vim.cmd('cq')
end
