; vim: ft=query
; format-ignore
(((symbol) @constant
  (#not-lua-match? @constant "^_*[A-Z][A-Z0-9_]*$"))
;                             ^ @luap
)

; format-ignore
(((tag
  (attributes
    (attribute
      (attribute_name) @keyword)))
  (#match? @keyword "^(:|v-bind|v-|\\@)"))
;                    ^ @regex
)

((comment) @injection.language
  .
  [
    (string_expression
      (string_fragment) @injection.content)
    (indented_string_expression
      (string_fragment) @injection.content)
  ]
  (#gsub! @injection.language "#%s*([%w%p]+)%s*" "%1")
  ;                            ^ @luap
  (#set! injection.combined))
