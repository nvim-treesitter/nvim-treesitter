; Preprocs
(preprocessor_directive) @keyword.directive

; Includes
"include" @keyword.import

; Keywords
[
  "assert"
  "class"
  "multiclass"
  "field"
  "let"
  "def"
  "defm"
  "defset"
  "defvar"
] @keyword

"in" @keyword.operator

; Conditionals
[
  "if"
  "else"
  "then"
] @keyword.conditional

; Repeats
"foreach" @keyword.repeat

; Variables
(identifier) @variable

(var) @variable.builtin

; Parameters
(template_arg
  (identifier) @variable.parameter)

; Types
(type) @type

[
  "bit"
  "int"
  "string"
  "dag"
  "bits"
  "list"
  "code"
] @type.builtin

(class
  name: (identifier) @type)

(multiclass
  name: (identifier) @type)

(def
  name: (value
    (_) @type))

(defm
  name: (value
    (_) @type))

(defset
  name: (identifier) @type)

(parent_class_list
  (identifier) @type
  (value
    (_) @type)?)

(anonymous_record
  (identifier) @type)

(anonymous_record
  (value
    (_) @type))

((identifier) @type
  (#lua-match? @type "^_*[A-Z][A-Z0-9_]+$"))

; Fields
(instruction
  (identifier) @variable.member)

(let_instruction
  (identifier) @variable.member)

; Functions
([
  (bang_operator)
  (cond_operator)
] @function
  (#set! "priority" 105))

; Operators
[
  "="
  "#"
  "-"
  ":"
  "..."
] @operator

; Literals
(string) @string

(code) @string.special

(integer) @number

(boolean) @boolean

(uninitialized_value) @constant.builtin

; Punctuation
[
  "{"
  "}"
] @punctuation.bracket

[
  "["
  "]"
] @punctuation.bracket

[
  "("
  ")"
] @punctuation.bracket

[
  "<"
  ">"
] @punctuation.bracket

[
  "."
  ","
  ";"
] @punctuation.delimiter

"!" @punctuation.special

; Comments
[
  (comment)
  (multiline_comment)
] @comment @spell

((comment) @keyword.directive
  (#lua-match? @keyword.directive "^.*RUN"))
