;; Basic
(identifier) @variable
(name) @variable
(type) @type
(comment) @comment
(get_node) @string
(string) @string
(float) @float
(integer) @number
(null) @constant
(setter) @function
(getter) @function
(static_keyword) @keyword
(tool_statement) @keyword
(breakpoint_statement) @keyword
(inferred_type) @operator
[(true) (false)] @boolean

(class_name_statement
  (name) @type) @keyword

(const_statement
  (name) @constant) @keyword

((identifier) @variable.builtin
  (#eq? @variable.builtin "self"))

;; Identifier naming conventions
((identifier) @type
  (#match? @type "^[A-Z]"))
((identifier) @constant
  (#match? @constant "^[A-Z][A-Z_0-9]*$"))
((identifier) @type
  (#match? @type "^[A-Z][A-Z_0-9]*$") . (_))

((attribute
    (identifier) @field)
 (#vim-match? @field "^([A-Z])@!.*$"))

;; Functions
(constructor_definition) @constructor

(function_definition
  (name) @function (parameters
    (identifier) @parameter)*)

(typed_parameter
  (identifier) @parameter)

(default_parameter
  (identifier) @parameter)

(call
  (identifier) @function)
(attribute_call
  (identifier) @function)

;; Alternations
["(" ")" "[" "]" "{" "}"] @punctuation.bracket

["," "." ":"] @punctuation.delimiter

["if" "elif" "else" "match"] @conditional

["for" "while" "break" "continue"] @repeat

[
  "~"
  "-"
  "*"
  "/"
  "%"
  "+"
  "-"
  "<<"
  ">>"
  "&"
  "^"
  "|"
  "<"
  ">"
  "=="
  "!="
  ">="
  "<="
  "!"
  "&&"
  "||"
  "="
  "+="
  "-="
  "*="
  "/="
  "%="
  "&="
  "|="
  "->"
] @operator

[
  "and"
  "as"
  "in"
  "is"
  "not"
  "or"
] @keyword.operator

[
  "pass"
  "return"
  "class"
  "class_name"
  "extends"
  "signal"
  "func"
  "enum"
  "var"
  "onready"
  "export"
  "setget"
  "remote"
  "master"
  "puppet"
  "remotesync"
  "mastersync"
  "puppetsync"
] @keyword
