[
  (block)
  (record_type)
  (record)
  (parenthesized_expression)
  (call_expression)
  (external_declaration)
  (function)
  (switch_match)
  (let_declaration)
  (jsx_element)
  (jsx_fragment)
  (jsx_self_closing_element)
] @indent.begin

[
  "}"
  ")"
  (jsx_closing_element)
] @indent.branch @indent.end

(jsx_self_closing_element
  "/" @indent.branch)

(jsx_self_closing_element
  "/"
  ">" @indent.end)

; </> is captured as 3 different anonymous nodes
(jsx_fragment
  "<"
  "<" @indent.branch)

(jsx_fragment
  ">"
  ">" @indent.end)
