(module_name) @structure

[
  (module_type_name)
  (type_constructor)
  (type_variable)
  (constructor_name)
  (tag)
] @type
(type_binding (type_constructor) @type)

(exception_definition (constructor_declaration (constructor_name) @exception))
(application_expression (value_path (value_name) @_raise)
                        (#eq? @_raise "raise")
                        (constructor_path) @exception)
(application_expression (value_path (value_name) @_raise)
                        (#eq? @_raise "raise")
                        (parenthesized_expression
                        (application_expression (constructor_path) @exception)))
(infix_expression (value_path (value_name) @_raise)
                  (#eq? @_raise "raise")
                  (application_expression (constructor_path) @exception))

(attribute_id) @property
(field_name) @field

(let_binding
  (value_name) @function
  (parameter))
(let_binding
  (value_name) @function
  (function_expression))

(application_expression . (value_path (value_name) @function))
(application_expression . (value_path (value_path (value_name) @function)))
(application_expression . (value_path (value_path (value_path (value_name) @function))))
(value_specification (value_name) @function (function_type))
(infix_expression (value_path (value_name) @function)
                  (infix_operator) @operator
                  (#eq? @operator "@@"))
(infix_expression (value_path (value_path (value_name) @function))
                  (infix_operator) @operator
                  (#eq? @operator "@@"))
(infix_expression (value_path (value_path (value_path (value_name) @function)))
                  (infix_operator) @operator
                  (#eq? @operator "@@"))
(infix_expression (infix_operator) @operator
                  (#eq? @operator "|>")
                  (value_path (value_name) @function))
(infix_expression (infix_operator) @operator
                  (#eq? @operator "|>")
                  (value_path (value_path (value_name) @function)))
(infix_expression (infix_operator) @operator
                  (#eq? @operator "|>")
                  (value_path (value_path (value_path (value_name) @function))))


(let_binding (parameter (label (label_name) @parameter)))
(let_binding (parameter (label_name) @parameter))
(let_binding (parameter (value_name) @parameter))
(let_binding (parameter (typed_pattern (value_name) @parameter)))
(function_type (typed_label (label_name) @parameter))

;; Literals
(unit) @constant
(boolean) @boolean
(number) @number
(character) @character

(comment) @comment

[(string) (quoted_string)] @string
(escape_sequence) @string.escape
(conversion_specification) @string.special

(infix_operator) @operator

[
  (let_operator)
  (and_operator)
  "let"
  "rec"
  "nonrec"
  "of"
  "in"
  "type"
  "val"
  "and"
  "struct"
  "sig"
  "functor"
  "external"
  "module"
  "match"
  "with"
  "when"
  "begin"
  "end"
  "fun"
  "function"
  "assert"
  "lazy"
  "as"
  "method"
  "new"
  "object"
  "inherit"
  "mutable"
  "virtual"
  "private"
  "constraint"
  "initializer"
  "class"
] @keyword

["exception" "try"] @exception

["open" "include"] @include

["if" "then" "else"] @conditional

["for" "to" "downto" "while" "do" "done"] @repeat

["(" ")" "[" "]" "{" "}" "[|" "|]" "[<" "[>"] @punctuation.bracket

[
 ","
 "."
 ";"
 "#"
 ":"
 "="
 "|"
 "->"
 "::"
 "~"
 "?"
 "|"
 "+"
 "-"
 "*"
 "'"
 ";;"
 ":>"
] @punctuation.delimiter

(ERROR) @error
