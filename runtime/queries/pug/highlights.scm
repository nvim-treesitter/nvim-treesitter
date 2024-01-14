(comment) @comment @spell

(tag_name) @tag

((tag_name) @constant.builtin
  ; https://www.script-example.com/html-tag-liste
  ; format-ignore
  (#any-of? @constant.builtin
    "head" "title" "base" "link" "meta" "style"
    "body" "article" "section" "nav" "aside" "h1" "h2" "h3" "h4" "h5" "h6" "hgroup" "header" "footer" "address"
    "p" "hr" "pre" "blockquote" "ol" "ul" "menu" "li" "dl" "dt" "dd" "figure" "figcaption" "main" "div"
    "a" "em" "strong" "small" "s" "cite" "q" "dfn" "abbr" "ruby" "rt" "rp" "data" "time" "code" "var" "samp" "kbd" "sub" "sup" "i" "b" "u" "mark" "bdi" "bdo" "span" "br" "wbr"
    "ins" "del"
    "picture" "source" "img" "iframe" "embed" "object" "param" "video" "audio" "track" "map" "area"
    "table" "caption" "colgroup" "col" "tbody" "thead" "tfoot" "tr" "td" "th "
    "form" "label" "input" "button" "select" "datalist" "optgroup" "option" "textarea" "output" "progress" "meter" "fieldset" "legend"
    "details" "summary" "dialog"
    "script" "noscript" "template" "slot" "canvas"))

(id) @constant

(class) @type

(doctype) @keyword.directive

(content) @none

(tag
  (attributes
    (attribute
      (attribute_name) @tag.attribute
      "=" @operator)))

((tag
  (attributes
    (attribute
      (attribute_name) @keyword)))
  (#match? @keyword "^(:|v-bind|v-|\\@)"))

(quoted_attribute_value) @string

(include
  (keyword) @keyword.import)

(extends
  (keyword) @keyword.import)

(filename) @string.special.path

(block_definition
  (keyword) @keyword)

(block_append
  (keyword)+ @keyword)

(block_prepend
  (keyword)+ @keyword)

(block_name) @module

(conditional
  (keyword) @keyword.conditional)

(case
  (keyword) @keyword.conditional
  (when
    (keyword) @keyword.conditional)+)

(each
  (keyword) @keyword.repeat)

(while
  (keyword) @keyword.repeat)

(mixin_use
  "+" @punctuation.delimiter
  (mixin_name) @function.call)

(mixin_definition
  (keyword) @keyword.function
  (mixin_name) @function)

(mixin_attributes
  (attribute_name) @variable.parameter)

(filter
  ":" @punctuation.delimiter
  (filter_name) @function.method.call)

(filter
  (attributes
    (attribute
      (attribute_name) @variable.parameter)))

[
  "("
  ")"
  "#{"
  "}"
  ; unsupported
  ; "!{"
  ; "#[" "]"
] @punctuation.bracket

[
  ","
  "."
  "|"
] @punctuation.delimiter

(buffered_code
  "=" @punctuation.delimiter)

(unbuffered_code
  "-" @punctuation.delimiter)

(unescaped_buffered_code
  "!=" @punctuation.delimiter)
