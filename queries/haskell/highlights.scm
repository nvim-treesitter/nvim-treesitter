(integer) @number
(exp_literal (float)) @float

(char) @character

(string) @string

(variable) @variable

(con_unit) @symbol

(comment) @comment

(function name: (variable) @function)

[
  "forall"
  "∀"
] @repeat

(pragma) @constant.macro

[
  "if"
  "then"
  "else"
] @conditional

[
  (constructor)
  (module)
] @constructor

;; True or False
((constructor) @_bool (#match? @_bool "(True|False)")) @boolean

(signature name: (variable) @type)
(constraint class: (class_name (type)) @type)
(class (class_head class: (class_name (type)) @type))
(instance (instance_head class: (class_name (type)) @type))

[
  (type)
] @type

[
  (qualified_module) ;; grabs the `.` (dot), ex: import System.IO
  (tycon_arrow)
  (operator)
  (constructor_operator)
  "::"
] @operator

[
  "import"
  "module"
] @include

[
  (where)
  "let"
  "in"
  "class"
  "instance"
  "data"
  "newtype"
  "family"
  "type"
  "qualified"
  "as"
  "deriving"
  "via"
  "stock"
  "anyclass"
  "do"
  "mdo"
  "rec"
] @keyword

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

; [
;   ","
; ] @punctuation.delimiter
