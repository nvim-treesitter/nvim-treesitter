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

((jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  (jsx_text) @markup.heading)
  (#eq? @_tag "title"))

((jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  (jsx_text) @markup.heading.1)
  (#eq? @_tag "h1"))

((jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  (jsx_text) @markup.heading.2)
  (#eq? @_tag "h2"))

((jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  (jsx_text) @markup.heading.3)
  (#eq? @_tag "h3"))

((jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  (jsx_text) @markup.heading.4)
  (#eq? @_tag "h4"))

((jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  (jsx_text) @markup.heading.5)
  (#eq? @_tag "h5"))

((jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  (jsx_text) @markup.heading.6)
  (#eq? @_tag "h6"))

((jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  (jsx_text) @markup.strong)
  (#any-of? @_tag "strong" "b"))

((jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  (jsx_text) @markup.italic)
  (#any-of? @_tag "em" "i"))

((jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  (jsx_text) @markup.strikethrough)
  (#any-of? @_tag "s" "del"))

((jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  (jsx_text) @markup.underline)
  (#eq? @_tag "u"))

((jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  (jsx_text) @markup.raw)
  (#any-of? @_tag "code" "kbd"))

((jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  (jsx_text) @markup.link.label)
  (#eq? @_tag "a"))

((jsx_attribute
  (property_identifier) @_attr
  (string
    (string_fragment) @string.special.url))
  (#any-of? @_attr "href" "src"))

((jsx_element) @_jsx_element
  (#set! @_jsx_element bo.commentstring "{/* %s */}"))

((jsx_attribute) @_jsx_attribute
  (#set! @_jsx_attribute bo.commentstring "// %s"))
