; Inspired by https://github.com/tree-sitter/tree-sitter/discussions/2025
; and https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md#highlights

(comment) @comment

(tag_id) @keyword.function
(tag_class) @keyword.type
(injector) @keyword.import
(directive_sign) @keyword.directive

[
 (string_start)
 (string_content)
 (string_end)
 ] @string

(bracket) @punctuation.bracket
(delimiter) @tag.delimiter
(parameter_name) @variable.parameter
(parameter_value) @tag.attribute

[
 (text_inline)
 (text_block)
] @markup.raw

; Markup tags
; https://developer.mozilla.org/en-US/docs/Web/HTML/Element
(tag_name) @tag
(
  (tag_name) @tag.builtin
  (#any-of? @tag.builtin
   "doctype" "html"
   "head" "title" "base" "link" "meta" "style"
   "body" "article" "section" "nav" "aside" "hgroup" "footer" "address"
   "p" "hr" "pre" "blockquote" "menu" "figure" "figcaption" "main" "div"
   "small" "s" "cite" "q" "dfn" "abbr" "rt" "rp" "data" "time" "code" "var" "samp" "kbd" "sub" "sup" "u" "mark" "bdi" "bdo" "span" "br" "wbr"
   "ins" "del"
   "picture" "source" "img" "iframe" "embed" "object" "param" "video" "audio" "track" "map" "area"
   "table" "caption" "colgroup" "col" "tbody" "thead" "tfoot" "tr" "td" "th"
   "form" "label" "input" "button" "select" "datalist" "optgroup" "option" "textarea" "output" "progress" "meter" "fieldset" "legend"
   "details" "summary" "dialog"
   "script" "noscript" "template" "slot" "canvas")
)
(
  (tag_name) @markup.strong
  (#any-of? @markup.strong "b" "strong")
)
(
  (tag_name) @markup.italic
  (#any-of? @markup.italic "i" "em")
)
(
  (tag_name) @markup.link
  (#any-of? @markup.link "a")
)
(
  (tag_name) @markup.heading
  (#any-of? @markup.heading "header" "h1" "h2" "h3" "h4" "h5" "h6")
)
(
  (tag_name) @markup.list
  (#any-of? @markup.list "ul" "ol" "li" "dl" "dt" "dd")
)
