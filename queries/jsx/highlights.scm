(jsx_element
  open_tag: (jsx_opening_element ["<" ">"] @tag.delimiter))
(jsx_element
  close_tag: (jsx_closing_element ["<" "/" ">"] @tag.delimiter))
(jsx_self_closing_element ["/" ">" "<"] @tag.delimiter)
(jsx_fragment [">" "<" "/"] @tag.delimiter)
(jsx_attribute (property_identifier) @tag.attribute)

(jsx_opening_element
  name: [
    ; <component>
    (identifier) @tag
    ; <Component.Foo>
    (nested_identifier (identifier) @tag (identifier) @tag)
  ])
; <Component>
(jsx_opening_element ((identifier) @tag.custom (#match? @tag.custom "^[A-Z]")))

(jsx_closing_element
  name: [
    ; </component>
    (identifier) @tag
    ; </Component.Foo>
    (nested_identifier (identifier) @tag (identifier) @tag)
  ])
; </Component>
(jsx_closing_element ((identifier) @tag.custom (#match? @tag.custom "^[A-Z]")))

(jsx_self_closing_element
  name: [
    ; <component />
    (identifier) @tag
    ; <Component.Foo />
    (nested_identifier (identifier) @tag (identifier) @tag)
  ])

; TODO: not sure why predicates do not work within alternations
; should be placed in between @tag and nested_identifier
; <Component />
(jsx_self_closing_element ((identifier) @tag.custom (#match? @tag.custom "^[A-Z]")))

(jsx_text) @none
