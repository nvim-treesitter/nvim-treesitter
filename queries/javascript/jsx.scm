(jsx_element
  open_tag: (jsx_opening_element ["<" ">"] @operator))
(jsx_element
  close_tag: (jsx_closing_element ["<" "/" ">"] @operator))

(jsx_closing_element name: (identifier) @variable.builtin)
(jsx_opening_element name: (identifier) @variable.builtin)

(jsx_text) @none
