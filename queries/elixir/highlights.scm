; Punctuation delimiters
[
  "%"
  ","
] @punctuation.delimiter

; Punctuation brackets
[
  "("
  ")"
  "<<"
  ">>"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

; Operators
[
  "!"
  "!="
  "!=="
  "&"
  "&&"
  "&&&"
  "*"
  "**"
  "+"
  "++"
  "+++"
  "-"
  "--"
  "---"
  "."
  ".."
  "/"
  "//"
  "::"
  "<"
  "<-"
  "<<<"
  "<<~"
  "<="
  "<>"
  "<|>"
  "<~"
  "<~>"
  "="
  "=="
  "==="
  "=>"
  "=~"
  ">"
  ">="
  ">>>"
  "@"
  "^"
  "and"
  "in"
  "not"
  "or"
  "when"
  "|"
  "|>"
  "||"
  "|||"
  "~>"
  "~>>"
  "~~~"
  "~"
] @operator

; Do/Fn blocks
[
  "do"
  "end"
  "fn"
] @keyword

; Exception blocks
[
  "catch"
  "rescue" 
] @exception

; Conditional blocks
[ 
  "else" 
] @conditional

; Comments
(comment) @comment

; Parser errors
(ERROR) @error

; Sigils
(sigil (sigil_name) @operator quoted_start: _ @operator quoted_end: _ @operator)

; Modules
(alias) @type

; Atoms
[
  (atom)
  (quoted_atom) 
] @symbol

; Keywords
(keyword) @symbol

; Strings
(string) @string

; Interpolation
(interpolation "#{" @string.escape (_)? "}" @string.escape)

; Escape sequences
(escape_sequence) @string.escape

; Integers
(integer) @number

; Floats
(float) @float

; Characters
[
  (char)
  (charlist)
] @character

; Booleans
(boolean) @boolean

; Nil
(nil) @constant.builtin

; Calling a local function
(call target: (identifier) @function) 

; Calling a remote function
(call target: (dot left: [
  (atom) @type 
  (_)
] right: (identifier) @function) (arguments))

; Module attributes
(unary_operator operator: "@" @constant operand: [
  (identifier) @constant
  (call target: (identifier) @constant)
])

; Unused identifiers
((identifier) @comment (#match? @comment 
  "^_([^_].*)?$"
))
 
; Calling a local def function
(call target: ((identifier) @keyword.function (#match? @keyword.function
  "^def(.*)?$"
)) (arguments (identifier) @function)?)

; Conditionals
(call target: (identifier) @conditional (#any-of? @conditional
  "case"
  "cond"
  "if"
  "receive"
  "unless"
  "with"
))

; Comprehensions
(call target: (identifier) @repeat (#any-of? @repeat
  "for"
))

; Exceptions
(call target: (identifier) @exception (#any-of? @exception
  "after"
  "catch"
  "else"
  "raise"
  "reraise"
  "rescue"
  "throw"
  "try"
))

; Special constants
((identifier) @constant.builtin (#any-of? @constant.builtin
  "__CALLER__"
  "__DIR__"
  "__ENV__"
  "__MODULE__"
  "__STACKTRACE__"
))
