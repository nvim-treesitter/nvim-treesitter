; Keywords
[
  "module"
  "let"
  "and"
  "in"
  "val"
  "begin"
  "end"
  "forall"
  "exists"
  "assert"
  "assert_norm"
  "assume"
  "calc"
  "when"
  "as"
  "of"
  "returns"
  "with"
  "match"
] @keyword

[
  "if"
  "then"
  "else"
] @keyword.conditional

"fun" @keyword.function

[
  "open"
  "include"
  "friend"
] @keyword.import

[
  "type"
  "effect"
  "new_effect"
  "layered_effect"
  "sub_effect"
  "class"
] @keyword.type

[
  "exception"
  "try"
] @keyword.exception

[
  "rec"
  "mutable"
] @keyword.modifier

; Qualifiers
(qualifier) @keyword.modifier

; Operators
[
  "="
  "<"
  ">"
  "<>"
  "<="
  ">="
  "=="
  "=!="
  "+"
  "-"
  "*"
  "/"
  "%"
  "**"
  "||"
  "&&"
  "!"
  "~"
  "->"
  "|>"
  "<|"
  "::"
  "@"
  "^"
  "$"
  "<:"
  ":="
  "\\/"
  "/\\"
  "<==>"
  "==>"
  "|"
  ":"
  "."
] @operator

; Pragmas
(pragma) @keyword.directive

; Module names
(module_declaration
  (uid_path) @module)

(open_declaration
  (uid_path) @module)

(include_declaration
  (uid_path) @module)

(friend_declaration
  (uid_path) @module)

(module_abbreviation
  (uid) @module)

(module_abbreviation
  (uid_path) @module)

; Type declarations
(type_declaration
  (lid) @type.definition)

; Constructor definitions
(constructor
  (uid) @constructor)

; Val declarations — function names
(val_declaration
  (lid) @function)

(val_declaration
  (uid_path_dot_lid
    (lid) @function))

; Let declarations — function names
(let_binding
  (lid) @function)

(let_binding
  (uid_path_dot_lid
    (lid) @function))

; Constructors (uppercase identifiers used in expressions/patterns)
(uid) @constructor

; Qualified paths
(uid_path
  (uid) @module)

(uid_path_dot_lid
  (uid) @module)

(uid_path_dot_lid
  (lid) @variable)

; Variables
(lid) @variable

; Type variables
(type_variable) @type

; Literals
(integer) @number

(string) @string

(char) @character

(boolean) @boolean

(unit) @constant.builtin

; Wildcard
(wildcard) @character.special

; Operator identifiers
(operator_id) @operator

; Attributes
(attribute) @attribute

; Comments
(line_comment) @comment @spell

(block_comment) @comment @spell

; Field access
(field_access
  (lid) @property)

(field_assignment
  (lid) @property)

(field_declaration
  (lid) @property)

(field_pattern
  (lid) @property)
