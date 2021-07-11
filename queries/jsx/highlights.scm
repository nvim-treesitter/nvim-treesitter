(jsx_element
  open_tag: (jsx_opening_element ["<" ">"] @tag.delimiter))
(jsx_element
  close_tag: (jsx_closing_element ["<" "/" ">"] @tag.delimiter))
(jsx_self_closing_element ["/" ">" "<"] @tag.delimiter)
(jsx_fragment [">" "<" "/"] @tag.delimiter)

(jsx_opening_element
 name: [
  ; <Component>
  (identifier) @tag
  ; <Component.Foo>
  (nested_identifier (identifier) @tag (identifier) @tag)
])

(jsx_closing_element
 name: [
  ; </Component>
  (identifier) @tag
  ; </Component.Foo>
  (nested_identifier (identifier) @tag (identifier) @tag)
])

(jsx_self_closing_element
 name: [
  ; <Component />
  (identifier) @tag
  ; <Component.Foo />
  (nested_identifier (identifier) @tag (identifier) @tag)
])

(jsx_text) @none
