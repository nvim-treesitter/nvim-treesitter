; highlights.scm
[
  (import)
  (package)
] @keyword.import

[
  (with)
  (as)
  (every)
  (some)
  (in)
  (not)
  (if)
  (contains)
  (else)
  (default)
  "null"
] @keyword

[
  "true"
  "false"
] @boolean

[
  (assignment_operator)
  (bool_operator)
  (arith_operator)
  (bin_operator)
] @operator

[
  (string)
  (raw_string)
] @string

(term
  (ref
    (var))) @variable

(comment) @comment @spell

(number) @number

(expr_call
  func_name: (fn_name
    (var) @function .))

(expr_call
  func_arguments: (fn_args
    (expr) @variable.parameter))

(rule_args
  (term) @variable.parameter)

[
  (open_paren)
  (close_paren)
  (open_bracket)
  (close_bracket)
  (open_curly)
  (close_curly)
] @punctuation.bracket

(rule
  (rule_head
    (var) @function.method))

(rule
  (rule_head
    (term
      (ref
        (var) @module)))
  (rule_body
    (query
      (literal
        (expr
          (expr_infix
            (expr
              (term
                (ref
                  (var)) @_output))))))
    (#eq? @_output @module)))
