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
 if_statement
  condition: (_) @indent
)
(
  (if_statement
    consequence: (_ ";" @indent_end) @_consequence
  ) @indent
  (#not-has-type? @_consequence compound_statement)
) 

;; if-else case,
;; with else that is not if/compound statement
(
  (if_statement
    consequence: (_ ";" @indent_end) @_consequence
    "else" @branch
    alternative: (_) @_alternative 
  )@indent
  (#not-has-type? @_consequence compound_statement)
  (#not-has-type? @_alternative compound_statement)
)

;; if-elseif-else case
(
  if_statement
  consequence: (_) @_consequence
  alternative: 
    (if_statement "else" @branch)
  (#not-has-type? @_consequence compound_statement)
)

;; if- else case
;; The alternative should be one of the cases below 
;; because the alternative is a nested tree inside the original if
;; dedent to offset the indent it should have gotten
;; Does not support multi chained bare ifs 
(
  (if_statement
    consequence: (_ ";" @indent_end) @_consequence
    "else" @branch
    alternative: 
      [
        (compound_statement) @dedent
        (if_statement 
          consequence: (_) @_consequence (#not-has-type? @_consequence compound_statement)
        ) @dedent
        (if_statement consequence: (compound_statement) @dedent)
      ] 
  )@indent
  (#not-has-type? @_consequence compound_statement)
)

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
