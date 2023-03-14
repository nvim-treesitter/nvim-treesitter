;; it seems for highlighting the latest query is the one being used
;; So lets order them by least to most concrete

[
  (line_comment)
  (block_comment)
] @comment

(bool) @boolean
(integer) @number
(float) @float
(character) @character

;; variables
;; references to upper case things are considered constructors
(
    (identifier) @variable
    (#lua-match? @variable "^[a-z]")
)
(
  (identifier) @type
  (#lua-match? @type "^[A-Z]")
)


;; strings and docstring
(source_file docstring: (string) @string.documentation)
(entity docstring: (string) @string.documentation)
(method docstring: (string) @string.documentation) ; docstring for methods without body
(behavior docstring: (string) @string.documentation) ; docstring for methods without body
(constructor docstring: (string) @string.documentation) ; docstring for methods without body
(method body: (block . (string) @string.documentation)) ; docstring for methods with body
(behavior body: (block . (string) @string.documentation))
(constructor body: (block . (string) @string.documentation))
(string) @string

;; Punctuation
[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket
[
  ";"
  "."
  ","
] @punctuation.delimiter

(this) @variable.builtin

(use) @include
[
  "for"
  "in"
  "while"
  "do"
  "repeat"
  "until"
] @repeat
[
 "if"
 "ifdef"
 "iftype"
 "then"
 "elseif"
 "else"
 "match"
] @conditional
[
  "break"
  "continue"
  "return"
  "error"
  "compile_error"
  "compile_intrinsic"
] @keyword.return
[
  "recover"
  "consume"
  "end"
  "try"
  "with"
] @keyword.control

[
  "as"
  "is"
  "isnt"
  "not"
  "and"
  "or"
  "xor"
  "digestof"
  "addressof"
  (location)
] @keyword.operator

[
  "fun"
  "be"
  "new"
] @keyword.function

[
  "var"
  "let"
  "embed"
] @storageclass

[
  (cap)
  (gencap)
] @type.qualifier

[
  "where"
  (entity_type)
  "object"
] @keyword

[
  (partial)
  "=>"
  "~"
  ".>"
  "+"
  "-"
  "*"
  "/"
  "%"
  "%%"
  "+~"
  "-~"
  "/~"
  "*~"
  "%~"
  "%%~"

  ">>"
  "<<"
  ">>~"
  "<<~"

  "=="
  "!="
  ">"
  "<"
  ">="
  "<="
] @operator

;; Types
(entity name: (identifier) @type)
(nominal_type name: (identifier) @type)
(typeparams (typeparam name: (identifier) @type))

;; constructors / methods / behaviors
(constructor name: (identifier) @constructor)
(method name: (identifier) @method)
(behavior name: (identifier) @method)

;; method calls
(call callee: (field_access field: (identifier) @method.call))
(call callee: (_) @method.call)
(ffi_call name: (_) @function.call)
(partial_application function: (identifier) @method.call)
(chain function: (identifier) @method.call)

;; fields and params
(field name: (identifier) @field docstring: (string)? @string.documentation)
(param name: (identifier) @parameter)
(lambdaparam name: (identifier) @parameter)

;; this.field is considered a member access
(field_access base: (this) field: (identifier) @field)

;; annotations
(annotations (identifier) @attribute)


