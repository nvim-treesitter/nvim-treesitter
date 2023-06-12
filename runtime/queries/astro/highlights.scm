; inherits: html_tags

(doctype) @constant

"<!" @tag.delimiter

"---" @punctuation.delimiter

[
  "{"
  "}"
] @punctuation.special

; custom components get `@type` highlighting
((start_tag
  (tag_name) @type)
  (#lua-match? @type "^[A-Z]"))

((end_tag
  (tag_name) @type)
  (#lua-match? @type "^[A-Z]"))

((self_closing_tag
  (tag_name) @type)
  (#lua-match? @type "^[A-Z]"))

((erroneous_end_tag
  (erroneous_end_tag_name) @type)
  (#lua-match? @type "^[A-Z]"))
