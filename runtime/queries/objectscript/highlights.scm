; -------------- Objectscript -------------
; Variables
; ^| e.g. '^||ppg', 'do', 'D'
; -----------------------------------------
(gvn) @variable.builtin

(ssvn) @variable.builtin

(lvn) @variable

(instance_variable) @variable.member

; String literals
; e.g. "Fo345349*_)(*_)8023841-40"" "
; -----------------------------------------
(string_literal) @string

(pattern_expression) @string.regexp

; Operators
(_
  operator: _ @operator)

; Numeric literals
; e.g. 12345
(numeric_literal) @number

; System variable name
; e.g. $IO, $SY[SYTEM]
(system_defined_variable) @function.builtin

; System defined functions
; e.g. $ASCII(62)
(system_defined_function) @function.builtin

(dollarsf
  ; $SYSTEM.Foo.Bar()
  (dollar_system_keyword) @function.builtin)

(property_name) @property

(parameter_name) @constant

(_
  parameter: _ @variable.parameter)

; Method invcoations
(instance_method_call) @function.method.call

(class_method_call
  (class_ref
    (class_name) @type.definition)
  (method_name) @function.method.call)

(oref_method
  (method_name) @function.method.call)

(_
  preproc_keyword: (_) @keyword.directive)

(_
  modifier: (_) @keyword.directive)

; User-defined functions
(extrinsic_function) @function.call

; Goto labels and locations
(_
  label: (_) @label)

(_
  offset: (_) @number)

(_
  routine: (_) @module)

; JSON literals
(json_boolean_literal) @boolean

(json_null_literal) @constant.builtin

(json_number_literal) @number

(json_string_literal) @string.escape

; Macros
(macro
  (macro_constant)) @constant.macro

(macro
  (macro_function)) @function.macro

; -------------- Objectscript Core -------------
; Commands
; e.g. 'set', 'do', 'D'
; -----------------------------------------
(_
  command_name: (_) @keyword)

(_
  macro_name: (_) @function.macro)

(_
  macro_arg: (_) @constant.macro)

(_
  mnemonic: (_) @constant.macro)

; Functions that can be on the LHS of a SET
(doable_dollar_functions) @function.builtin

; non-extrinsic routine call
(routine_tag_call) @function.call

; Technically elseif and else_block are not statements,
; so we need ot query them explicitly
;(elseif_block command_name: (_) @keyword)
;(else_block command_name: (_) @keyword)
"{" @punctuation.bracket

"}" @punctuation.bracket

; Comments
; e.g. '// fj;lkasdfj', '#; sklfjas;k', '; sklfjas','/* sdfs */'
[
  (line_comment_1)
  (line_comment_2)
  (line_comment_3)
  (block_comment)
] @comment

(embedded_html
  (keyword_embedded_html) @keyword.directive
  "<" @keyword.directive
  ">" @keyword.directive)

; (embedded_sql_hash
;   (keyword_embedded_sql_hash) @keyword.directive
; )
; (embedded_sql_amp
;   (keyword_embedded_sql_amp) @keyword.directive
;   "(" @keyword.directive
;   ")" @keyword.directive
;   (embedded_sql_reverse_marker) @keyword.directive
; )
(embedded_sql_amp
  (keyword_embedded_sql_amp) @keyword.directive
  "(" @keyword.directive
  ")" @keyword.directive)

(embedded_sql_hash
  (keyword_embedded_sql_hash) @keyword.directive
  "(" @keyword.directive
  ")" @keyword.directive)

(embedded_js
  (keyword_embedded_js) @keyword.directive
  "<" @keyword.directive
  ">" @keyword.directive)

(embedded_xml
  (keyword_embedded_xml) @keyword.directive
  "<" @keyword.directive
  ">" @keyword.directive)

(tag) @label

; Lock type specifications
(locktype) @variable.parameter.builtin

(_
  keyword: (_) @keyword)

; (identifier) @variable
; Alternatively
; (class_statement (_ class_statement_keyword: (_) @keyword ) .)
"{" @punctuation.bracket

"}" @punctuation.bracket

; @class.name capture group is not suppported in nvim highlighter
; (class_definition class_name: (identifier) @class.name)
(include_clause
  (identifier) @keyword.import)

(property
  (identifier) @property)

(parameter
  (identifier) @constant)

(projection
  (identifier) @type.definition)

(trigger
  (identifier) @type.definition)

(index
  (identifier) @type.definition)

(relationship
  (identifier) @type.definition)

(foreignkey
  (identifier) @type.definition)

(xdata
  (identifier) @constant)

(typename) @type

(class_definition
  class_name: (identifier) @type
  (class_extends
    (identifier) @type))

(method_definition
  (identifier
    (identifier)) @function)

(query
  (identifier) @function)

(argument
  (identifier) @variable.parameter)

(keyword_name) @keyword

(class_keywords
  (_
    rhs: _ @constant.builtin))

(parameter_keywords
  (_
    rhs: _ @constant.builtin))

(property_keywords
  (_
    rhs: _ @constant.builtin))

(xdata_keywords
  (_
    rhs: _ @constant.builtin))

(method_keywords
  (_
    rhs: _ @constant.builtin))

(trigger_keywords
  (_
    rhs: _ @constant.builtin))

(query_keywords
  (_
    rhs: _ @constant.builtin))

(index_keywords
  (_
    rhs: _ @constant.builtin))

(foreignkey_keywords
  (_
    rhs: _ @constant.builtin))

(projection_keywords
  (_
    rhs: _ @constant.builtin))

(relationship_keywords
  (_
    rhs: _ @constant.builtin))

(documatic_line) @comment.documentation
