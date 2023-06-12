[
  (block)
  (record_type)
  (record)
  (parenthesized_expression)
  (call_expression)
  (function_type_parameters)
  (function)
  (switch_match)
  (let_declaration)
  (jsx_element)
  (jsx_fragment)
  (jsx_self_closing_element)
  (object_type)
] @indent.begin

[
  "}"
  ")"
  (jsx_closing_element)
] @indent.branch @indent.end

(jsx_self_closing_element
  "/" @indent.branch
  ">"? @indent.end)

; </> is captured as 3 different anonymous nodes
(jsx_fragment
  "<"
  "<" @indent.branch)

(jsx_fragment
  ">"
  ">" @indent.end)

(comment) @indent.auto
