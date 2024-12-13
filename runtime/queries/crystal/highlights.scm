(identifier) @variable

((constant) @constant
 (#match? @constant "^[A-Z\\d_]+$"))

(require) @function.method.builtin

[
  "alias"
  "begin"
  "break"
  "case"
  "class"
  "def"
  "do"
  "end"
  "ensure"
  "in"
  "module"
  "next"
  "of"
  "rescue"
  "then"
  "unless"
  "until"
  "when"
  "while"
] @keyword
["return" "yield"] @keyword.return
["if" "else" "elsif"] @keyword.conditional
["rescue"] @keyword.exception

(pseudo_constant) @constant.builtin

; literals
(string) @string

(symbol) @string.special.symbol

(regex) @string.regex

(string_escape_sequence) @escape

[(integer) (float)] @number

[(true) (false)] @boolean

(nil) @constant.builtin

(interpolation
  "#{" @punctuation.special
  "}" @punctuation.special) @embedded

(comment) @comment

; Operators

(operator) @operator
"=" @operator

[
  ","
  ";"
  "."
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

(class_def name: [(constant) (generic_type)] @type.definition)

(module_def name: [(constant) (generic_type)] @module)

(struct_def name: [(constant) (generic_type)] @type.definition)

(enum_def name: [(constant)] @type)

(method_def name: [(identifier) (constant)] @function.method)

(method_def name: (identifier) @constructor (#eq? @constructor "initialize"))

(param name: [(identifier)] @variable.parameter)

(param type: [(constant) (generic_instance_type)] @type)

(call receiver: [(constant) (generic_type)] @type)

(array of: (constant) @type)
(hash [(constant)] @type)
(generic_instance_type) @type

(call method: (identifier) @keyword (#eq? @keyword "new"))

(call method: (identifier) @function.call (#not-eq? @function.call "new"))

[
  (class_var)
  (instance_var)
] @property
