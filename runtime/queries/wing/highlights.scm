(identifier) @variable

(reference_identifier) @variable

(member_identifier) @property

; Classes
(custom_type) @type

(class_field
  name: (identifier) @variable.member)

(class_definition
  name: (identifier) @type)

(method_definition
  name: (identifier) @function.method)

; Functions
(keyword_argument_key) @variable.parameter

(call
  caller:
    (reference
      (nested_identifier
        property: (member_identifier) @function.method.call)))

(call
  caller:
    (reference
      (reference_identifier) @function.method.call))

; Primitives
(number) @number

(duration) @constant

(string) @string

(bool) @boolean

(builtin_type) @type.builtin

(json_container_type) @type.builtin

; Special
(comment) @comment @spell

[
  "("
  ")"
  "{"
  "}"
] @punctuation.bracket

[
  "-"
  "+"
  "*"
  "/"
  "%"
  "<"
  "<="
  "="
  "=="
  "!"
  "!="
  ">"
  ">="
  "&&"
  "??"
  "||"
] @operator

[
  ";"
  "."
  ","
] @punctuation.delimiter

[
  "as"
  "bring"
  "class"
  "else"
  "for"
  "if"
  "in"
  "let"
  "new"
  "return"
  (inflight_specifier)
] @keyword
