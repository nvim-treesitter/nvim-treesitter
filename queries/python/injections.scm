(call
  function: (attribute
              object: (identifier) @_re)
  arguments: (argument_list (string
                              (string_content) @injection.content) @_string)
  (#eq? @_re "re")
  (#lua-match? @_string "^r.*")
  (#set! injection.language "regex"))

((comment) @injection.content
 (#set! injection.language "comment"))


; doc-strings
; see queries/python/highlights.scm

(module . (expression_statement (string (string_content) @injection.content)
           (#set! injection.language "comment")
           ))

(class_definition
  body:
    (block
      . (expression_statement (string (string_content) @injection.content)
        (#set! injection.language "comment")
        )))

(function_definition
  body:
    (block
      . (expression_statement (string (string_content) @injection.content)
        (#set! injection.language "comment")
        )))
