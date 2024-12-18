[
  "alias"
  "annotation"
  "begin"
  "break"
  "case"
  "do"
  "end"
  "ensure"
  "extend"
  "in"
  "include"
  "lib"
  "next"
  "select"
  "then"
  "when"
] @keyword
["def" "fun"] @keyword.function
["class" "enum" "module" "struct" "type" "union"] @keyword.type
["require"] @keyword.import
["return" "yield"] @keyword.return
["if" "else" "elsif" "unless"] @keyword.conditional
["while" "until"] @keyword.repeat
["rescue"] @keyword.exception
[(private) (protected) "abstract"] @keyword.modifier

(pseudo_constant) @constant.builtin

; literals
(string) @string

(symbol) @string.special.symbol

(regex) @string.regex

(heredoc_content) @string
[(heredoc_start) (heredoc_end)] @label

(string_escape_sequence) @escape

(integer) @number
(float) @number.float

[(true) (false)] @boolean

(nil) @constant.builtin

(interpolation
  "#{" @punctuation.special
  "}" @punctuation.special) @embedded

(comment) @comment

; Operators

[
"="
"=>"
"->"
] @operator

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

; Types
[(constant) (generic_instance_type) (generic_type)] @type

(annotation (constant) @attribute)

(method_def name: [(identifier) (constant)] @function.method)

(param name: [(identifier)] @variable.parameter)

[
  (class_var)
  (instance_var)
] @variable.member

; function calls
(call method: (identifier) @function.call)
