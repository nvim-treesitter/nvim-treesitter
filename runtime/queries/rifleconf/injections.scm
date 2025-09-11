; These are all interpreted as regex when evaluated
; https://github.com/ranger/ranger/blob/38bb8901004b75a407ffee4b9e176bc0a436cb15/ranger/ext/rifle.py#L273-L282
(binary_condition_expression
  (binary_condition_identifier) @_keyword
  (identifier) @injection.content
  (#any-of? @_keyword "match" "ext" "mime" "name" "path")
  (#set! injection.language "regex"))

; highlight any commands using the bash tree-sitter parser
(command_list
  (command) @injection.content
  (#set! injection.include-children)
  (#set! injection.language "bash"))

((comment) @injection.content
  (#set! injection.language "comment"))
