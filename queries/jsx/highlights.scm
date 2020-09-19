(jsx_element
  open_tag: (jsx_opening_element ["<" ">"] @tag.delimiter))
(jsx_element
  close_tag: (jsx_closing_element ["<" "/" ">"] @tag.delimiter))
(jsx_self_closing_element ["/" ">" "<"] @tag.delimiter)
(jsx_fragment [">" "<" "/"] @tag.delimiter)

(jsx_opening_element
  name: (identifier) @tag)

(jsx_closing_element
  name: (identifier) @tag)

(jsx_self_closing_element 
  name: (identifier) @tag)

(jsx_opening_element ((identifier) @type
 (#match? @type "^[A-Z]")))

(jsx_closing_element ((identifier) @type
 (#match? @type "^[A-Z]")))

(jsx_self_closing_element ((identifier) @type
 (#match? @type "^[A-Z]")))

(variable_declarator ((identifier) @type
 (#match? @type "^[A-Z]")))

(jsx_text) @none
