; @value tags without double-quotes
((bare_format_string) @injection.content
  (#set! injection.language "printf"))

; @value tags with double quotes
((literal_format_string) @injection.content
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "printf"))

; injected code snippets
((snippet_tag
  (attributes
    (attribute
      name: (identifier) @_attribute_key
      value: (attribute_value
        [
          (identifier) @injection.language
          (string_literal
            (quoted_value) @injection.language)
        ])))
  body: (description) @injection.content)
  (#eq? @_attribute_key "lang"))

; html content
((description) @injection.content
  (#set! injection.language "html"))

; markdown content
((markdown_description) @injection.content
  (#set! injection.language "markdown_inline"))
