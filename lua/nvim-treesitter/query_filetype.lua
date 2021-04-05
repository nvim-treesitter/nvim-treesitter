local M = {}

function M.omnifunc(base)
  local filename = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
  local ok, query_lang = pcall(vim.fn.fnamemodify, filename, ":p:h:t")
  query_lang = filename ~= "" and query_lang
  query_lang = ok and query_lang
  --if not query_lang then
    --query_lang = query_lang_from_playground_buf(query_buf)
  --end

  local ok, parser_info = pcall(vim.treesitter.inspect_language, query_lang)

  parser_info = ok and parser_info


  if parser_info then
    local items = {}
    for _, f in pairs(parser_info.fields) do
      if f:find(base, 1, true) == 1 then
        table.insert(items, f)
      end
    end
    for _, s in pairs(parser_info.symbols) do
      local text = s[2] and s[1] or '"'..vim.fn.escape(s[1], '\\')..'"'
      if text:find(base, 1, true) == 1 then
        table.insert(items, text)
      end
    end
    return {words = items, refresh= 'always'}
  else
    return -2
  end
end

return M
