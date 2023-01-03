[
  (jsx_fragment)
  (jsx_element)
  (jsx_self_closing_element)
  (jsx_expression)
] @indent

(jsx_fragment
  ("<" ">" (_) "<" @branch "/" ">" @indent_end)
)

(jsx_closing_element (">" @indent_end))
(jsx_self_closing_element ">" @indent_end)

[
  (jsx_closing_element)
  ">"
] @branch
; <button
; />
(jsx_self_closing_element "/" @branch)
