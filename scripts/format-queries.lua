#!/usr/bin/env -S nvim -l

local ts = vim.treesitter
local get_node_text = ts.get_node_text

---@type string[]
local files

local arg = _G.arg[1] or "."
if arg:match ".*%.scm$" then
  files = { arg }
else
  files = vim.fn.split(vim.fn.glob(arg .. "/**/*.scm"))
end

ts.query.add_predicate("kind-eq?", function(match, _, _, pred)
  local cap = match[pred[2]]
  local node = type(cap) == "table" and cap[1] or cap
  if not node then
    return true
  end

  local types = { unpack(pred, 3) }
  return vim.tbl_contains(types, node:type())
end, true)

ts.query.add_predicate("is-start-of-line?", function(match, _, _, pred)
  local cap = match[pred[2]]
  local node = type(cap) == "table" and cap[1] or cap
  if not node then
    return true
  end
  local start_row, start_col = node:start()
  return vim.fn.indent(start_row + 1) == start_col
end)

--- Control the indent here. Change to \t if uses tab instead
local indent_str = "  "
local indent_width_plus_one = 3
local textwidth = 100

-- Query to control the formatter
local format_queries = [[
;;query
;; Ignore next node with `; format-ignore`
(
  (comment) @_pattern
  .
  (_) @format.ignore
  (#lua-match? @_pattern "^;+%s*format%-ignore"))

;; {{{
;; Add newlines to top level nodes
;; {{{
;; Preserve inline comments
(program
  . (_)
  (comment) @format.prepend-newline
  (#is-start-of-line? @format.prepend-newline))
(program
  . (_)
  (comment) @_comment
  .
  (comment) @format.prepend-newline
  (#not-is-start-of-line? @_comment)
  (#is-start-of-line? @format.prepend-newline))
; Extra newline for modelines
(program
  (comment) @_modeline
  .
  (_) @format.prepend-newline
  (#is-start-of-line? @_modeline)
  (#contains? @_modeline "^;+%s*inherits:"))
(program
  (comment) @_modeline
  .
  (_) @format.prepend-newline
  (#is-start-of-line? @_modeline)
  (#contains? @_modeline "^;+%s*extends%s*$"))
;; }}}
;; Making sure all top-level patterns are separated
(program
  (_) @format.append-newline)
(program
  (_) @format.cancel-append .)
(program
  . (_)
  [
    (list)
    (grouping)
    (named_node)
    (anonymous_node)
    (missing_node)
    (field_definition)
  ] @format.prepend-newline)

(program
  (comment) @_comment
  .
  [
    (list)
    (grouping)
    (named_node)
    (anonymous_node)
    (missing_node)
    (field_definition)
    (comment)
  ] @format.cancel-prepend
  (#is-start-of-line? @_comment)
  (#not-lua-match? @_comment "^;+%s*inherits:")
  (#not-lua-match? @_comment "^;+%s*extends%s*$"))
;; }}}

;; delims
[
  ":"
  "."
] @format.append-space
(predicate
  "." @format.cancel-append @format.replace
  (#gsub! @format.replace "%." "#"))
(
  "." @format.prepend-space @format.cancel-append
  .
  ")")

;; List handler
;; Only starts indent if 2 or more elements
(list
  "[" @format.indent.begin
  "]" @format.indent.dedent)
;; Otherwise, remove brackets
(list
  "[" @format.remove @format.cancel-append
  .
  (_) @format.cancel-append
  .
  "]" @format.remove)
;; [ ... ] @capture1 @capture2
;; Append newlines for nodes inside the list
(list
  (_) @format.append-newline
  (#not-kind-eq? @format.append-newline "capture" "quantifier"))

;; (_), "_" and _ handler
;; Start indents if it's one of these patterns
(named_node
  [
    "_"
    name: (identifier)
  ] @format.indent.begin
  .
  [
    (list)              ; (foo [...])
    (grouping)          ; (foo ((foo)))
    (negated_field)     ; (foo !field)
    (field_definition)  ; (foo field: (...))
    (named_node)        ; (foo (bar))
    (predicate)         ; (named_node (#set!))
    (anonymous_node)
    (missing_node)
    "."
  ])
;; Honoring comment's position within a node
(named_node
  [
    "_"
    name: (identifier)
  ] @format.indent.begin
  .
  (comment) @_comment
  (#is-start-of-line? @_comment))
(named_node
  [
    "_"
    name: (identifier)
  ] @format.indent.begin @format.cancel-append
  .
  "."? @format.prepend-newline
  .
  (comment) @format.prepend-space
  (#not-is-start-of-line? @format.prepend-space))

;; Add newlines for other nodes, in case the top node is indented
(named_node
  [
    (list)
    (grouping)
    (negated_field)
    (field_definition)
    (named_node)
    (predicate)
    (anonymous_node)
    (missing_node)
    "."
  ] @format.append-newline)

;; Collapse closing parentheses
(named_node
  [
    "_"
    name: (identifier)
    (_)
  ] @format.cancel-append
  .
  ")"
  (#not-kind-eq? @format.cancel-append "comment"))

;; All captures should be separated with a space
(capture) @format.prepend-space

; ( (_) ) handler
(grouping
  "("
  .
  [
    (named_node)                  ; ((foo))
    (list)                        ; ([foo] (...))
    (anonymous_node)              ; ("foo")
    (missing_node)
    (grouping . (_))
  ] @format.indent.begin
  .
  (_))
(grouping
  "("
  .
  (grouping) @format.indent.begin
  (predicate))
(grouping
  "("
  [
    (anonymous_node)
    (missing_node)
    (named_node)
    (list)
    (predicate)
    (grouping . (_))
    (field_definition)
    "."
  ] @format.append-newline
  (_) .)
;; Collapsing closing parens
(grouping
  (_) @format.cancel-append . ")"
  (#not-kind-eq? @format.cancel-append "comment"))
(grouping
  (capture) @format.prepend-space)
(missing_node
  name: (_) @format.prepend-space)
;; Remove unnecessary parens
(grouping
  "(" @format.remove
  .
  (_)
  .
  ")" @format.remove .)
(grouping
  "(" @format.remove
  .
  [
    (grouping)
    (anonymous_node
      name: (string) .)
    (missing_node
      name: (_) .)
    (named_node
      [
        "_"
        name: (identifier)
      ] .)
  ]
  .
  ")" @format.remove
  .
  (capture))

; Separate this query to avoid capture duplication
(predicate
  "(" @format.indent.begin @format.cancel-append)
(predicate
  (parameters
    (comment) @format.prepend-newline
    .
    (_) @format.cancel-prepend)
  (#is-start-of-line? @format.prepend-newline))
(predicate
  (parameters
    (_) @format.prepend-space)
  (#set! conditional-newline))
(predicate
  (parameters
    .
    (capture)
    . (_) @format.prepend-space)
  (#set! lookahead-newline)
  (#set! conditional-newline))

;; Comment related handlers
(comment) @format.append-newline
;; comment styling. Feel free to change in the future
((comment) @format.replace
  (#gsub! @format.replace "^;+(%s*.-)%s*$" ";%1"))
;; Preserve end of line comments
(
  [
    "."
    ":"
    (list)
    (grouping)
    (named_node)
    (anonymous_node)
    (missing_node)
    (negated_field)
  ] @format.cancel-append
  .
  (quantifier)?
  .
  "."? @format.prepend-newline ; Make sure anchor are not eol but start of newline
  .
  (comment) @format.prepend-space
  (#not-is-start-of-line? @format.prepend-space))
]]

---@param lines string[]
---@param lines_to_append string[]
local function append_lines(lines, lines_to_append)
  for i = 1, #lines_to_append, 1 do
    lines[#lines] = lines[#lines] .. lines_to_append[i]
    if i ~= #lines_to_append then
      lines[#lines + 1] = ""
    end
  end
end

---@param bufnr integer
---@param node TSNode
---@param lines string[]
---@param q table<string, vim.treesitter.query.TSMetadata>
---@param level integer
local function iter(bufnr, node, lines, q, level)
  --- Sometimes 2 queries apply append twice. This is to prevent the case from happening
  local apply_newline = false
  for child, _ in node:iter_children() do
    local id = child:id()
    if apply_newline then
      apply_newline = false
      lines[#lines + 1] = string.rep(indent_str, level)
    end
    if q["format.ignore"][id] then
      local text = vim.split(get_node_text(child, bufnr):gsub("\r\n?", "\n"), "\n", { trimempty = true })
      append_lines(lines, text)
    elseif not q["format.remove"][id] then
      if not q["format.cancel-prepend"][id] then
        if q["format.prepend-newline"][id] then
          lines[#lines + 1] = string.rep(indent_str, level)
        elseif q["format.prepend-space"][id] then
          if not q["format.prepend-space"][id]["conditional-newline"] then
            lines[#lines] = lines[#lines] .. " "
          elseif child:byte_length() + 1 + #lines[#lines] > textwidth then
            lines[#lines + 1] = string.rep(indent_str, level)
          else
            -- Do a rough guess of the actual byte length. If it's larger than `columns` then add a newline first
            -- column - byte_end + byte_start
            local _, _, byte_start = child:start()
            local _, _, byte_end = node:end_()
            if
              q["format.prepend-space"][id]["lookahead-newline"]
              and (byte_end - byte_start) + #lines[#lines] > textwidth
            then
              lines[#lines + 1] = string.rep(indent_str, level)
            else
              lines[#lines] = lines[#lines] .. " "
            end
          end
        end
      end
      if q["format.replace"][id] then
        append_lines(lines, vim.split(q["format.replace"][id].text, "\n", { trimempty = true }))
      elseif
        child:named_child_count() == 0
        -- Workaround to preserve string content
        or child:type() == "string"
      then
        append_lines(
          lines,
          vim.split(string.gsub(get_node_text(child, bufnr), "\r\n?", "\n"), "\n+", { trimempty = true })
        )
      else
        iter(bufnr, child, lines, q, level)
      end
      if q["format.indent.begin"][id] then
        level = level + 1
        apply_newline = true
      elseif q["format.indent.dedent"][id] then
        lines[#lines] = string.sub(lines[#lines], indent_width_plus_one)
      end
    end
    if q["format.cancel-append"][id] then
      apply_newline = false
    elseif q["format.append-newline"][id] then
      apply_newline = true
    elseif q["format.append-space"][id] then
      lines[#lines] = lines[#lines] .. " "
    end
  end
end

---@param bufnr integer
---@param queries string
local function format(bufnr, queries)
  local lines = { "" }
  -- stylua: ignore
  local map = {
    ['format.ignore'] = {},           -- Ignore the node and its children
    ['format.indent.begin'] = {},     -- +1 shiftwidth for all nodes after this
    ['format.indent.dedent'] = {},    -- -1 shiftwidth for this line only
    ['format.prepend-space'] = {},    -- Prepend a space before inserting the node
    ['format.prepend-newline'] = {},  -- Prepend a \n before inserting the node
    ['format.append-space'] = {},     -- Append a space after inserting the node
    ['format.append-newline'] = {},   -- Append a newline after inserting the node
    ['format.cancel-append'] = {},    -- Cancel any `@format.append-*` applied to the node
    ['format.cancel-prepend'] = {},   -- Cancel any `@format.prepend-*` applied to the node
    ['format.replace'] = {},          -- Dedicated capture used to store results of `(#gsub!)`
    ['format.remove'] = {},           -- Do not add the syntax node to the result, i.e. brackets [], parens ()
  }
  local root = ts.get_parser(bufnr, "query"):parse(true)[1]:root()
  local query = ts.query.parse("query", queries)
  for id, node, metadata in query:iter_captures(root, bufnr) do
    if query.captures[id]:sub(1, 1) ~= "_" then
      map[query.captures[id]][node:id()] = metadata and (metadata[id] and metadata[id] or metadata) or {}
    end
  end

  iter(bufnr, root, lines, map, 0)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end

for _, file in ipairs(files) do
  local buf = vim.fn.bufadd(file)
  vim.fn.bufload(file)
  vim.api.nvim_set_current_buf(buf)
  format(buf, format_queries)
end

vim.cmd "silent wa!"
