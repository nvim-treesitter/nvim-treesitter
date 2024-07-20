; comments and block-comments
((comment) @injection.content
  (#set! injection.language "comment"))

; dynamic invocation like & "$env:ChocolateyInstall\bin\choco.exe"
(command
  (command_invokation_operator) @_operator
  (command_name_expr
    (string_literal) @injection.content)
  (#eq? @_operator "&")
  (#set! injection.language "powershell")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children))

; switch -regex
(switch_statement
  (switch_parameters
    (switch_parameter) @_parameter)
  (switch_body
    (switch_clauses
      (switch_clause
        (switch_clause_condition
          (string_literal) @injection.content))))
  (#eq? @_parameter "-regex")
  (#set! injection.language "regex")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children))

; Multiline strings
([
  (verbatim_here_string_characters)
  (expandable_here_string_literal)
] @injection.content
  (#offset! @injection.content 0 2 0 -2)
  (#set! injection.language "comment"))
