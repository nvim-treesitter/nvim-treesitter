[
  (compound_statement) 
  (field_declaration_list)
  (case_statement)
  (enumerator_list)
  (compound_literal_expression)
  (initializer_list)
  (init_declarator)
  (expression_statement)
] @indent

(
  ERROR
    "for" "(" @indent ";" ";" ")" @indent_end)
(
  (for_statement
    body: (_) @_body
  ) @indent
  (#not-has-type? @_body compound_statement)
)

(
  while_statement
    condition: (_) @indent
)
(
  (while_statement
    body: (_) @_body
  ) @indent
  (#not-has-type? @_body compound_statement)
)

(
  (if_statement)
  (ERROR "else") @indent
)

(
 if_statement
  condition: (_) @indent
)
;; Make sure all cases of if-else are tagged with @indent
;; So we will offset the indents for the else case
(
  (if_statement
    consequence: (compound_statement)
    "else" @branch
    alternative: 
      [
        [ "{" "}" ] @branch
        (compound_statement ["{" "}"] @branch)
        (_)
      ] 
  ) @indent
)
(
  (if_statement
    consequence: (_ ";" @indent_end) @_consequence
  ) @indent
  (#not-has-type? @_consequence compound_statement)
)
(
  (if_statement
    consequence: (_) @_consequence
    "else" @branch
    alternative: 
      [
        [ "{" "}" ] @branch
        (compound_statement ["{" "}"] @branch)
        (_)
      ] 
  )
  (#not-has-type? @_consequence compound_statement)
)

;; Dedent for chaining if-else statements
;; this will go recursively through each if-elseif
;; if-elseif -> second `if` is dedented once, indented twice
;; if-elseif-elseif -> third `if` is dedented twice, indented 3 times
;; -> all are indented once
(
  (if_statement
    consequence: (_)
    alternative: 
      [
        (if_statement consequence: (compound_statement) @dedent)
        (_)
      ] @dedent
  )
)

(compound_statement "}" @indent_end)

[
  ")"
  "}"
  (statement_identifier)
] @branch

[
  "#define"
  "#ifdef"
  "#ifndef"
  "#elif"
  "#if"
  "#else"
  "#endif"
] @zero_indent

[
  (preproc_arg)
  (string_literal)
] @ignore

((ERROR (parameter_declaration)) @aligned_indent
 (#set! "delimiter" "()"))
([(argument_list) (parameter_list)] @aligned_indent
  (#set! "delimiter" "()"))

(comment) @auto
