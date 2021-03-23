
;; Primitives
(boolean) @boolean
(comment) @comment
(shebang_comment) @comment
(identifier) @variable
((identifier) @variable.builtin
  (#eq? @variable.builtin "self"))
(nil) @constant.builtin
(number) @number
(string) @string
(table_constructor ["{" "}"] @constructor)
(varargs "..." @constant.builtin)
[ "," "." ":" ";" ] @punctuation.delimiter

(escape_sequence) @string.escape
(format_specifier) @string.escape

;; Basic statements/Keywords
[ "if" "then" "elseif" "else" ] @conditional
[ "for" "while" "repeat" "until" ] @repeat
[ "in" "local" "return" (break) (goto) "do" "end" ] @keyword
(label) @label

;; Global isn't a real keyword, but it gets special treatment in these places
(var_declaration "global" @keyword)
(type_declaration "global" @keyword)
(function_statement "global" @keyword)
(record_declaration "global" @keyword)
(enum_declaration "global" @keyword)

;; Ops
(bin_op (op) @operator)
(unary_op (op) @operator)
[ "=" "as" ] @operator

;; Functions
(function_statement
  "function" @keyword.function
  . name: (_) @function)
(anon_function
  "function" @keyword.function)
(function_body "end" @keyword.function)

(arg name: (identifier) @parameter)

(function_signature
  (arguments
    . (arg name: (identifier) @variable.builtin))
  (#eq? @variable.builtin "self"))

(typeargs
  "<" @punctuation.bracket
  . (_) @parameter
  . ("," . (_) @parameter)*
  . ">" @punctuation.bracket)

(function_call
  (identifier) @function . (arguments))
(function_call
  (index (_) key: (identifier) @function) . (arguments))
(function_call
  (method_index (_) key: (identifier) @function) . (arguments))

;; Types
(record_declaration
  . "record" @keyword
  name: (identifier) @type)
(anon_record . "record" @keyword)
(record_body
  (record_entry
    . [ "record" "enum" ] @keyword
    . key: (identifier) @type))
(record_body
  (record_entry
    . "type" @keyword
    . key: (identifier) @type . "="))
(record_body
  (metamethod "metamethod" @keyword))
(record_body
  (userdata) @keyword)

(enum_declaration
  "enum" @keyword
  name: (identifier) @type)

(type_declaration "type" @keyword)
(type_declaration (type_name) @type)
(simple_type) @type
(type_index) @type
(type_union "|" @operator)
(function_type "function" @type)

;; The rest of it
(var_declaration
  (var name: (identifier) @variable))
(var_declaration
  (var
    "<" @punctuation.bracket
    . attribute: (attribute) @attribute
    . ">" @punctuation.bracket))
[ "(" ")" "[" "]" "{" "}" ] @punctuation.bracket

;; Only highlight format specifiers in calls to string.format
;; string.format('...')
;(function_call
;  called_object: (index
;    (identifier) @base
;    key: (identifier) @entry)
;  arguments: (arguments .
;    (string (format_specifier) @string.escape))
;
;  (#eq? @base "string")
;  (#eq? @entry "format"))

;; ('...'):format()
;(function_call
;  called_object: (method_index
;    (string (format_specifier) @string.escape)
;    key: (identifier) @func-name)
;    (#eq? @func-name "format"))


(ERROR) @error
