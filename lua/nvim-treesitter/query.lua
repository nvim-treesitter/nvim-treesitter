local api = vim.api
local ts = vim.treesitter
local utils = require 'nvim-treesitter.utils'

local M = {}

local function read_query_files(filenames)
  local contents = {}

  for _,filename in ipairs(filenames) do
    vim.list_extend(contents, vim.fn.readfile(filename))
  end

  return table.concat(contents, '\n')
end

-- Creates a function that checks whether a certain query exists
-- for a specific language.
local function get_query_guard(query)
  return function(lang)
    return M.get_query(lang, query) ~= nil
  end
end

-- Some treesitter grammars extend others.
-- We can use that to import the queries of the base language
M.base_language_map = {
  cpp = {'c'},
  typescript = {'javascript'},
  tsx = {'typescript', 'javascript'},
}

M.query_extensions = {
  javascript = { 'jsx' },
  tsx = {'javascript.jsx'}
}

M.has_locals = get_query_guard('locals')
M.has_highlights = get_query_guard('highlights')

function M.get_query(lang, query_name)
  local query_files = api.nvim_get_runtime_file(string.format('queries/%s/%s.scm', lang, query_name), true)
  local query_string = ''

  if #query_files > 0 then
    query_string = read_query_files(query_files) .. "\n" .. query_string
  end

  for _, base_lang in ipairs(M.base_language_map[lang] or {}) do
    local base_files = api.nvim_get_runtime_file(string.format('queries/%s/%s.scm', base_lang, query_name), true)
    if base_files and #base_files > 0 then
        query_string = read_query_files(base_files) .. "\n" .. query_string
    end
  end

  local extensions = M.query_extensions[lang]
  for _, ext in ipairs(extensions or {}) do
    local l = lang
    local e = ext
    if e:match('%.') ~= nil then
       l = e:match('.*%.'):sub(0, -2)
       e = e:match('%..*'):sub(2, -1)
    end
    local ext_files = api.nvim_get_runtime_file(string.format('queries/%s/%s.scm', l, e), true)
    if ext_files and #ext_files > 0 then
      query_string = read_query_files(ext_files) .. "\n" .. query_string
    end
  end

  if #query_string > 0 then
    return ts.parse_query(lang, query_string)
  end
end

 --This function is copied from Neovims treesitter.lua to enforece same behavior
local magic_prefixes = {['\\v']=true, ['\\m']=true, ['\\M']=true, ['\\V']=true}
local function check_magic(str)
  if string.len(str) < 2 or magic_prefixes[string.sub(str,1,2)] then
    return str
  end
  return '\\v'..str
end

local function compile_regex(regex)
  if not M._regex_cache then
    M._regex_cache = {}
  end
  if not M._regex_cache[regex] then
    local re = vim.regex(check_magic(regex))
    M._regex_cache[regex] = re
    return re
  else
    return M._regex_cache[regex]
  end
end

local function strip_beginning(lines, regex, continuation_line_regex)
  local current_col = 0
  local current_line = 0

  local re_first = compile_regex('^('..regex..')')
  local re_next = compile_regex('^('..continuation_line_regex..')')
  for linenr, line in ipairs(lines) do
    current_line = linenr
    local re = (linenr == 1 and re_first or re_next)
    local match_start, match_end = re:match_str(line)
    if match_start ~= 0 then
      break
    else
      current_col = match_end
    end
    if match_end ~= vim.str_byteindex(line, #line) then
      break
    end
    current_line = current_line + 1
  end
  return current_line - 1, current_col
end

local function strip_end(lines, regex, continuation_line_regex)
  local current_col = 0
  local line_diff = 0
  local re_last = compile_regex('('..regex..')$')
  local re_before = compile_regex('('..continuation_line_regex..')$')
  for linenr = #lines, 1, -1 do
    local line = lines[linenr]
    line_diff = #lines - linenr
    local re = linenr == #lines and re_last or re_before
    local match_start, match_end = re:match_str(line)

    if match_end ~= vim.str_byteindex(line, #line) then
      break
    else
      current_col = match_start
    end
    if match_start ~= 0 then
      break
    end
    line_diff = line_diff + 1
  end
  return line_diff, current_col
end

function M.iter_prepared_matches(query, qnode, bufnr, start_row, end_row)
  -- A function that splits  a string on '.'
  local function split(string)
    local t = {}
    for str in string.gmatch(string, "([^.]+)") do
      table.insert(t, str)
    end

    return t
  end

  -- Given a path (i.e. a List(String)) this functions inserts value at path
  local function insert_to_path(object, path, value)
    local curr_obj = object

    for index=1,(#path -1) do
      if curr_obj[path[index]] == nil then
        curr_obj[path[index]] = {}
      end

      curr_obj = curr_obj[path[index]]
    end

    curr_obj[path[#path]] = value
  end

  local matches = query:iter_matches(qnode, bufnr, start_row, end_row)

  return function()
    local pattern, match = matches()
    if pattern ~= nil then
      local prepared_match = {}

      -- Extract capture names from each match
      for id, node in pairs(match) do
        local name = query.captures[id] -- name of the capture in the query
        if name ~= nil then
          local path = split(name)
          insert_to_path(prepared_match, path, { node=node })
        end
      end

      -- Add some predicates for testing
      local preds = query.info.patterns[pattern]
      if preds then
        for _, pred in pairs(preds) do
          if pred[1] == "set!" and type(pred[2]) == "string" then
            insert_to_path(prepared_match, split(pred[2]), pred[3])
          end
          if pred[1] == "strip!" and #pred == 4 then
            local capture_name = query.captures[pred[2]]
            local regex = pred[3]
            local continuation_line_regex = pred[4]

            local function process_range()
              local node = utils.get_at_path(prepared_match, capture_name..'.node')
              local ts_utils = require 'nvim-treesitter.ts_utils'
              local node_lines = ts_utils.get_node_text(node, bufnr)
              local start_line, start_col, end_line, _ = node:range()

              local strip_line, strip_col = strip_beginning(node_lines, regex, continuation_line_regex)
              strip_beginning(node_lines, regex, continuation_line_regex)
              start_line = start_line + strip_line
              if strip_line == 0 then
                start_col = start_col + strip_col
              else
                start_col = strip_col
              end
              local strip_line, strip_col = strip_end(node_lines, regex, continuation_line_regex)
              end_line = end_line - strip_line
              local end_col
              if strip_line == 0 then
                end_col = strip_col
              else
                end_col = strip_col + (end_line == start_line and start_col or 0)
              end

              end_line = math.max(end_line, start_line)
              if end_line == start_line then
                end_col = math.max(end_col, start_col)
              end
              return {start_line, start_col, end_line, end_col}
            end

            insert_to_path(prepared_match,
                           split(capture_name..'.process_range'),
                           process_range)
          end
        end
      end

      return prepared_match
    end
  end
end

return M
