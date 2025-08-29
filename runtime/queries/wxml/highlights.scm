; Comments
(comment) @comment @spell

; Text
(text) @spell

; Tag names
(tag_name) @tag

((tag_name) @tag.builtin
  (#any-of? @tag.builtin "wxs" "template" "import" "include" "slot" "block"))

; Attributes
(attribute_name) @tag.attribute

(attribute_value) @string

(quoted_attribute_value) @string

; WeChat specific attributes
((attribute_name) @keyword.directive
  (#lua-match? @keyword.directive "^wx:"))

((attribute_name) @keyword.conditional
  (#any-of? @keyword.conditional "wx:if" "wx:elif" "wx:else"))

((attribute_name) @keyword.repeat
  (#any-of? @keyword.repeat "wx:for" "wx:for-index" "wx:for-item"))

((attribute_name) @keyword
  (#lua-match? @keyword "^bind"))

((attribute_name) @keyword
  (#lua-match? @keyword "^catch"))

((attribute_name) @keyword
  (#lua-match? @keyword "^mut%-bind"))

((attribute_name) @keyword
  (#lua-match? @keyword "^model:"))

((attribute_name) @keyword
  (#lua-match? @keyword "^data-"))

((attribute
  (attribute_name) @_attr
  (quoted_attribute_value) @string.special.url)
  (#any-of? @_attr "href" "src")
  (#offset! @string.special.url 0 1 0 -1))

; Entity references
(entity) @character.special

; Interpolation delimiters
(interpolation_start) @punctuation.special

(interpolation_end) @punctuation.special

[
  "<"
  ">"
  "</"
  "/>"
] @tag.delimiter

"=" @operator
