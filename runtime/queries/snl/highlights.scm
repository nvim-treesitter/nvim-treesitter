(identifier) @variable

[
  "enum"
  "struct"
  "union"
] @keyword.type

[
  "assign"
  "const"
  "entry"
  "exit"
  "foreign"
  "monitor"
  "option"
  "program"
  "ss"
  "state"
  "sync"
  "syncq"
  "to"
  "typename"
] @keyword

"sizeof" @keyword.operator

"return" @keyword.return

[
  "while"
  "for"
  "continue"
  "break"
] @keyword.repeat

[
  "if"
  "else"
  "when"
] @keyword.conditional

[
  "#elif"
  "#else"
  "#endif"
  "#if"
  "#ifdef"
  "#ifndef"
  (preproc_directive)
  (line_marker)
] @keyword.directive

"#define" @keyword.directive.define

"#include" @keyword.import

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  "."
  ","
  ";"
] @punctuation.delimiter

[
  "%%"
  "%{"
  "}%"
  "..."
] @punctuation.special

[
  "+"
  "-"
  "*"
  "&"
  "!"
  "~"
  "++"
  "--"
  "="
  ">>"
  "<<"
  "/"
  ">"
  ">="
  "<"
  "<="
  "=="
  "!="
  "^"
  "|"
  "||"
  "&&"
  "%"
  "*="
  "/="
  "%="
  "+="
  "-="
  "<<="
  ">>="
  "&="
  "^="
  "|="
] @operator

(comma_expr
  "," @operator)

[
  (true)
  (false)
] @boolean

(conditional_expression
  [
    "?"
    ":"
  ] @keyword.conditional.ternary)

[
  (string_literal)
  (system_lib_string)
] @string

(parameter_expansion
  [
    "{"
    "}"
  ] @string.special)

(parameter_expansion
  (identifier) @constant)

(escape_sequence) @string.escape

(null) @constant.builtin

[
  (number_literal)
  (char_literal)
] @number

((preproc_arg) @function.macro
  (#set! "priority" 90))

(preproc_defined) @function.macro

(call_expression
  function: (identifier) @function.call)

(call_expression
  function: (field_expression
    field: (identifier) @function.call))

(function_declarator
  declarator: (identifier) @function)

(preproc_function_def
  name: (identifier) @function.macro)

(field_expression
  field: (identifier) @property)

(type_qualifier) @keyword.modifier

(structdef
  name: (identifier) @type.definition)

[
  (basetype)
  (type_expr)
] @type

(prim_type) @type.builtin

(program
  name: (identifier) @constant)

(state_set
  name: (identifier) @function)

(state
  name: (identifier) @function)

(transition
  name: (identifier) @function)

(option
  name: (identifier) @constant)

((identifier) @constant
  (#lua-match? @constant "^[A-Z][A-Z%d_]*$"))

(preproc_def
  name: (_) @constant.macro)

(preproc_call
  directive: (preproc_directive) @_u
  argument: (_) @constant.macro
  (#eq? @_u "#undef"))

(comment) @comment @spell

(param_decl
  (declarator
    (identifier) @variable.parameter))

((identifier) @variable.parameter
  (#has-ancestor? @variable.parameter param_decl))

(param_decl
  (declarator
    (pointer_declarator) @variable.parameter))

(preproc_params
  (identifier) @variable.parameter)

((call_expression
  function: (_) @function.builtin)
  (#any-of? @function.builtin
    "delay" "pvPut" "pvPutComplete" "pvArrayPutComplete" "pvPutCancel" "pvArrayPutCancel" "pvGet"
    "pvGetComplete" "pvArrayGetComplete" "pvGetCancel" "pvArrayGetCancel" "pvGetQ" "pvFreeQ"
    "pvFlushQ" "pvAssign" "pvAssignSubst" "pvMonitor" "pvArrayMonitor" "pvStopMonitor"
    "pvArrayStopMonitor" "pvSync" "pvArraySync" "pvCount" "pvStatus" "pvSeverity" "pvMessage"
    "pvTimeStamp" "pvAssigned" "pvConnected" "pvArrayConnected" "pvIndex" "pvFlush" "pvChannelCount"
    "pvAssignCount" "pvConnectCount" "efSet" "efClear" "efTest" "efTestAndClear" "macValueGet"
    "optGet"))

((identifier) @constant.builtin
  (#any-of? @constant.builtin
    "pvStatOK" "pvStatERROR" "pvStatDISCONN" "pvStatREAD" "pvStatWRITE" "pvStatHIHI" "pvStatHIGH"
    "pvStatLOLO" "pvStatLOW" "pvStatSTATE" "pvStatCOS" "pvStatCOMM" "pvStatTIMEOUT" "pvStatHW_LIMIT"
    "pvStatCALC" "pvStatSCAN" "pvStatLINK" "pvStatSOFT" "pvStatBAD_SUB" "pvStatUDF" "pvStatDISABLE"
    "pvStatSIMM" "pvStatREAD_ACCESS" "pvStatWRITE_ACCESS" "pvSevrOK" "pvSevrERROR" "pvSevrNONE"
    "pvSevrMINOR" "pvSevrMAJOR" "pvSevrINVALID" "DEFAULT" "ASYNC" "SYNC" "NOEVFLAG"))
