; Types

; Javascript

; Variables
;-----------
(identifier) @variable

; Properties
;-----------

(property_identifier) @property
(shorthand_property_identifier) @property
(private_property_identifier) @property

(variable_declarator
  name: (object_pattern
    (shorthand_property_identifier_pattern))) @variable

; Special identifiers
;--------------------

((identifier) @type
 (#lua-match? @type "^[A-Z]"))

((identifier) @constant
 (#lua-match? @constant "^_*[A-Z][A-Z%d_]*$"))

((shorthand_property_identifier) @constant
 (#lua-match? @constant "^_*[A-Z][A-Z%d_]*$"))

((identifier) @variable.builtin
 (#any-of? @variable.builtin
  "arguments"
  "module"
  "console"
  "window"
  "document"
  "Object"
  "Function"
  "Boolean"
  "Symbol"
  "Number"
  "Math"
  "Date"
  "String"
  "RegExp"
  "Map"
  "Set"
  "WeakMap"
  "WeakSet"
  "Promise"
  "Intl"
  "Array"
  "Int8Array"
  "Uint8Array"
  "Uint8ClampedArray"
  "Int16Array"
  "Uint16Array"
  "Int32Array"
  "Uint32Array"
  "Float32Array"
  "Float64Array"
  "ArrayBuffer"
  "DataView"
  "Error"
  "EvalError"
  "InternalError"
  "RangeError"
  "ReferenceError"
  "SyntaxError"
  "TypeError"
  "URIError"))

((identifier) @function.builtin
 (#any-of? @function.builtin
  "eval"
  "isFinite"
  "isNaN"
  "parseFloat"
  "parseInt"
  "decodeURI"
  "decodeURIComponent"
  "encodeURI"
  "encodeURIComponent"
  "require"))

; Function and method definitions
;--------------------------------

(function name: (identifier) @function)
(function_declaration name: (identifier) @function)
(generator_function name: (identifier) @function)
(generator_function_declaration name: (identifier) @function)
(method_definition name: [(property_identifier) (private_property_identifier)] @method)
(method_definition name: (property_identifier) @method.builtin
  (#eq? @method.builtin "constructor"))

(pair
  key: (property_identifier) @method
  value: (function))
(pair
  key: (property_identifier) @method
  value: (arrow_function))

(assignment_expression
  left: (member_expression
    property: (property_identifier) @method)
  right: (arrow_function))
(assignment_expression
  left: (member_expression
    property: (property_identifier) @method)
  right: (function))

(variable_declarator
  name: (identifier) @function
  value: (arrow_function))
(variable_declarator
  name: (identifier) @function
  value: (function))

(assignment_expression
  left: (identifier) @function
  right: (arrow_function))
(assignment_expression
  left: (identifier) @function
  right: (function))

; Function and method calls
;--------------------------

(call_expression function: (identifier) @function.call)

(call_expression function:
  (member_expression property:
    [(property_identifier) (private_property_identifier)] @method.call))

; Constructor
;------------

(new_expression
  constructor: (identifier) @constructor)

; Variables
;----------
(namespace_import (identifier) @namespace)

; Literals
;---------

[(this) (super)] @variable.builtin

[(true) (false)] @boolean

[(null) (undefined)] @constant.builtin

(comment) @comment @spell

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^/[*][*][^*].*[*]/$"))

(hash_bang_line) @preproc

(string) @string @spell
(template_string) @string
(escape_sequence) @string.escape
(regex_pattern) @string.regex
(regex "/" @punctuation.bracket.regex)
(regex_flags) @string.regex.flags
((string_fragment) @string.special
 (#eq? @string.special "use strict"))

(number) @number
((identifier) @number (#any-of? @number "NaN" "Infinity"))

; Punctuation
;------------

"..." @punctuation.special

[";" "." ","] @punctuation.delimiter
(member_expression "." @punctuation.delimiter.member)
(optional_chain) @punctuation.delimiter.member

(pair ":" @punctuation.delimiter)
(pair_pattern ":" @punctuation.delimiter)

[
  "--"
  "-"
  "-="
  "&&"
  "+"
  "++"
  "+="
  "&="
  "/="
  "**="
  "<<="
  "<"
  "<="
  "<<"
  "="
  "=="
  "==="
  "!="
  "!=="
  "=>"
  ">"
  ">="
  ">>"
  "||"
  "%"
  "%="
  "*"
  "**"
  ">>>"
  "&"
  "|"
  "^"
  "??"
  "*="
  ">>="
  ">>>="
  "^="
  "|="
  "&&="
  "||="
  "??="
] @operator

(binary_expression "/" @operator)
(ternary_expression ["?" ":"] @conditional.ternary)
(unary_expression ["!" "~" "-" "+"] @operator)
(unary_expression ["delete" "void" "typeof"] @keyword.operator)

["(" ")" "[" "]" "{" "}"] @punctuation.bracket

(string ["'" "\""] @punctuation.quote.string)
(template_string "`" @punctuation.quote.string)
((template_substitution ["${" "}"] @punctuation.special @punctuation.bracket.string) @none)

(array ["[" "]"] @punctuation.bracket.array)
(array "," @punctuation.delimiter.array)

(object ["{" "}"] @punctuation.bracket.object)
(object (pair ":" @punctuation.delimiter.object))
(object "," @punctuation.delimiter.object)

(if_statement condition: (parenthesized_expression ["(" ")"] @punctuation.bracket.conditional))
(if_statement consequence: (statement_block ["{" "}"] @punctuation.bracket.conditional))
(if_statement alternative: (else_clause (statement_block ["{" "}"] @punctuation.bracket.conditional)))

(switch_statement body: (switch_body ["{" "}"] @punctuation.bracket.conditional))
(switch_case ":" @punctuation.delimiter.conditional)
(switch_default ":" @punctuation.delimiter.conditional)

(for_statement ["(" ")"] @punctuation.bracket.repeat)
(for_statement body: (statement_block ["{" "}"] @punctuation.bracket.repeat))
(for_in_statement ["(" ")"] @punctuation.bracket.repeat)
(for_in_statement body: (statement_block ["{" "}"] @punctuation.bracket.repeat))
(while_statement condition: (parenthesized_expression ["(" ")"] @punctuation.bracket.repeat))
(while_statement body: (statement_block ["{" "}"] @punctuation.bracket.repeat))
(do_statement body: (statement_block ["{" "}"] @punctuation.bracket.repeat))
(do_statement condition: (parenthesized_expression ["(" ")"] @punctuation.bracket.repeat))

(with_statement body: (statement_block ["{" "}"] @punctuation.bracket.with))

(try_statement body: (statement_block ["{" "}"] @punctuation.bracket.exception))
(catch_clause ["(" ")"] @punctuation.bracket.exception)
(catch_clause body: (statement_block ["{" "}"] @punctuation.bracket.exception))
(finally_clause body: (statement_block ["{" "}"] @punctuation.bracket.exception))

(class_declaration body: (class_body ["{" "}"] @punctuation.bracket.class))

(function_declaration parameters: (formal_parameters ["(" ")"] @punctuation.bracket.function))
(function_declaration parameters: (formal_parameters "," @punctuation.delimiter.function))
(function_declaration body: (statement_block ["{" "}"] @punctuation.bracket.function))
(generator_function_declaration parameters: (formal_parameters ["(" ")"] @punctuation.bracket.function))
(generator_function_declaration parameters: (formal_parameters "," @punctuation.delimiter.function))
(generator_function_declaration body: (statement_block ["{" "}"] @punctuation.bracket.function))
(function parameters: (formal_parameters ["(" ")"] @punctuation.bracket.function))
(function parameters: (formal_parameters "," @punctuation.delimiter.function))
(function body: (statement_block ["{" "}"] @punctuation.bracket.function))
(arrow_function parameters: (formal_parameters ["(" ")"] @punctuation.bracket.function))
(arrow_function parameters: (formal_parameters "," @punctuation.delimiter.function))
(arrow_function "=>" @punctuation.special.function)
(arrow_function body: (statement_block ["{" "}"] @punctuation.bracket.function))
(generator_function_declaration "*" @punctuation.special.function)
(method_definition "*" @punctuation.special.function)
(method_definition parameters: (formal_parameters ["(" ")"] @punctuation.bracket.function))
(method_definition parameters: (formal_parameters "," @punctuation.delimiter.function))
(method_definition body: (statement_block ["{" "}"] @punctuation.bracket.function))

; Keywords
;----------

["if" "else" "switch" "case" "default"] @keyword @conditional

["import" "from" "as"] @keyword @include

["new" "delete" "typeof" "in" "instanceof" "void"] @keyword @keyword.operator

["for" "do" "of" "while"] @keyword @repeat

(for_in_statement operator: "in" @keyword @repeat)

["async" "await"] @keyword @keyword.async

[
"class"
"extends"
"static" @storageclass
"get"
"set"
] @keyword @keyword.class

"debugger" @keyword @keyword.debugger

"with" @keyword @keyword.with

["const" "let" "var"] @keyword @keyword.declaration

["return" "yield" "export"] @keyword @keyword.return
(export_statement "default" @keyword @keyword.return)

(break_statement "break" @keyword @keyword.break)
(continue_statement "continue" @keyword @keyword.continue)

"function" @keyword @keyword.function

["throw" "try" "catch" "finally"] @keyword @exception
