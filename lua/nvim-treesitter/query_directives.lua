local query = vim.treesitter.query

query.add_directive("ecma_template_literal!", function(
  match,
  _, --[[ pattern ]]
  _, --[[ bufnr ]]
  predicate,
  metadata
)
  local node = match[predicate[2]]
  local content = { { node:range() } }

  -- remove backticks
  content[1][2] = content[1][2] + 1
  content[1][4] = content[1][4] - 1

  for child in node:iter_children() do
    -- create subranges
    if child:type() == "template_substitution" then
      local child_range = { child:range() }
      local last_content_range = content[#content]
      local first_part = { last_content_range[1], last_content_range[2], child_range[1], child_range[2] - 1 }
      local second_part = { child_range[3], child_range[4], last_content_range[3], last_content_range[4] }
      content[#content] = first_part
      content[#content + 1] = second_part
    end
  end

  metadata.content = content
end)
