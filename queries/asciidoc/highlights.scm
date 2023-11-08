; adapted from https://github.com/cathaysia/tree-sitter-asciidoc/blob/develop/queries/highlights.scm

(title0) @text.title.0
(title1) @text.title.1
(title2) @text.title.2
(title3) @text.title.3
(title4) @text.title.4
(title5) @text.title.5

[
  (list_item_mark)
  (table_start)
  (table_end)
  (attr_mark)
  (line_breaks)
  (page_breaks)
] @punctuation.special

[
  (attr_name)
  (attr_value)
] @attribute

(comment) @comment @spell

(replacement) @character.special

[
  (kbd)
  (footnote)
  (passthrough)
  (audio)
  (video)
  (image)
  (xref)
] @function

(note) @text.note
(tip) @text.note @text.emphasis
(important) @text.note @text.strong
(caution) @text.danger
(warning) @text.warning

[
  (url)
  (audio_url)
  (xref_url)
] @text.uri

(emphasis) @text.emphasis
(strong) @text.strong
(highlight) @text.warning
(footnote_content) @text.reference

((code) @punctuation.delimiter
 (#set! "priority" 99))

(code_language) @label

[
  (code_content)
  (monospace)
  (kbd_content)
  (passthrough_content)
  (audio_title)
] @text.literal @nospell

(paragraph) @text @spell
