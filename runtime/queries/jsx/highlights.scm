(jsx_element
  open_tag: (jsx_opening_element
    [
      "<"
      ">"
    ] @tag.delimiter))

(jsx_element
  close_tag: (jsx_closing_element
    [
      "</"
      ">"
    ] @tag.delimiter))

(jsx_self_closing_element
  [
    "<"
    "/>"
  ] @tag.delimiter)

(jsx_attribute
  (property_identifier) @tag.attribute)

(jsx_opening_element
  name: (identifier) @tag.builtin)

(jsx_closing_element
  name: (identifier) @tag.builtin)

(jsx_self_closing_element
  name: (identifier) @tag.builtin)

(jsx_opening_element
  ((identifier) @tag
    (#lua-match? @tag "^[A-Z]")))

; Handle the dot operator effectively - <My.Component>
(jsx_opening_element
  (member_expression
    (identifier) @tag.builtin
    (property_identifier) @tag))

(jsx_closing_element
  ((identifier) @tag
    (#lua-match? @tag "^[A-Z]")))

; Handle the dot operator effectively - </My.Component>
(jsx_closing_element
  (member_expression
    (identifier) @tag.builtin
    (property_identifier) @tag))

(jsx_self_closing_element
  ((identifier) @tag
    (#lua-match? @tag "^[A-Z]")))

; Handle the dot operator effectively - <My.Component />
(jsx_self_closing_element
  (member_expression
    (identifier) @tag.builtin
    (property_identifier) @tag))

(html_character_reference) @tag

(jsx_text) @none @spell

(html_character_reference) @character.special
