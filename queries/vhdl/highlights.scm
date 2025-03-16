(line_comment
  (comment_content) @spell) @comment

(block_comment
  (comment_content) @spell) @comment.documentation

(identifier) @variable

[
  "access"
  "after"
  "alias"
  "architecture"
  "array"
  ; "assume"
  "attribute"
  "block"
  "body"
  "component"
  "configuration"
  "context"
  ; "cover"
  "disconnect"
  "entity"
  ; "fairness"
  "file"
  "force"
  "generate"
  "generic"
  "group"
  "label"
  "literal"
  "map"
  "new"
  "package"
  "parameter"
  "port"
  "property"
  "range"
  "reject"
  "release"
  ; "restrict"
  "sequence"
  "transport"
  "unaffected"
  "view"
  ; "vmode"
  ; "vpkg"
  ; "vprop"
  "vunit"
] @keyword

[
  (ALL)
  (OTHERS)
  "<>"
  (DEFAULT)
  (OPEN)
] @constant.builtin

[
  "is"
  "begin"
  "end"
] @keyword

(parameter_specification
  "in" @keyword)

[
  "process"
  "wait"
  "on"
  "until"
] @keyword.coroutine

(end_process
  "end" @keyword.coroutine)

(timeout_clause
  "for" @keyword.coroutine)

[
  "function"
  "procedure"
] @keyword.function

(subprogram_end
  "end" @keyword.function)

[
  "to"
  "downto"
  "of"
] @keyword.operator

[
  "library"
  "use"
] @keyword.import

[
  "subtype"
  "type"
  "record"
  "units"
  "constant"
  "signal"
  "variable"
] @keyword.type

[
  "protected"
  "private"
  "pure"
  "impure"
  "inertial"
  "postponed"
  ; "strong"
  "guarded"
  "out"
  "inout"
  "linkage"
  "buffer"
  "register"
  "bus"
  "shared"
] @keyword.modifier

(mode
  "in" @keyword.modifier)

(force_mode
  "in" @keyword.modifier)

[
  "while"
  "loop"
  "next"
  "exit"
] @keyword.repeat

(end_loop
  "end" @keyword.repeat)

(for_loop
  "for" @keyword.repeat)

(block_configuration
  "for" @keyword)

(configuration_specification
  "for" @keyword)

(component_configuration
  "for" @keyword)

(end_for
  "for" @keyword)

"return" @keyword.return

[
  "assert"
  "report"
  "severity"
] @keyword.debug

[
  "if"
  "then"
  "elsif"
  "case"
] @keyword.conditional

(end_if
  "end" @keyword.conditional)

(end_case
  "end" @keyword.conditional)

(when_element
  "when" @keyword.conditional)

(case_generate_alternative
  "when" @keyword.conditional)

(else_statement
  "else" @keyword.conditional)

(else_generate
  "else" @keyword.conditional)

[
  "with"
  "select"
] @keyword.conditional.ternary

(when_expression
  "when" @keyword.conditional.ternary)

(else_expression
  "else" @keyword.conditional.ternary)

(else_waveform
  "else" @keyword.conditional.ternary)

(else_expression_or_unaffected
  "else" @keyword.conditional.ternary)

"null" @constant.builtin

(user_directive) @keyword.directive

(protect_directive) @keyword.directive

(warning_directive) @keyword.directive

(error_directive) @keyword.directive

(if_conditional_analysis
  "if" @keyword.directive)

(if_conditional_analysis
  "then" @keyword.directive)

(elsif_conditional_analysis
  "elsif" @keyword.directive)

(else_conditional_analysis
  "else" @keyword.directive)

(end_conditional_analysis
  "end" @keyword.directive)

(end_conditional_analysis
  "if" @keyword.directive)

(directive_body) @keyword.directive

(directive_constant_builtin) @constant.macro

(directive_error) @comment.error

(directive_protect) @keyword.directive

(directive_warning) @comment.warning

[
  (condition_conversion)
  (relational_operator)
  (sign)
  (adding_operator)
  (exponentiate)
  (variable_assignment)
  (signal_assignment)
  "*"
  "/"
  ":"
  "|"
  "=>"
] @operator

[
  (unary_operator)
  (logical_operator)
  (shift_operator)
  "mod"
  "not"
  "rem"
] @keyword.operator

[
  "'"
  ","
  "."
  ";"
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "<<"
  ">>"
] @punctuation.bracket

"@" @punctuation.special

[
  (decimal_integer)
  (string_literal_std_logic)
] @number

(decimal_float) @number.float

(bit_string_length) @property

(bit_string_base) @type.builtin

(bit_string_value) @number

(based_literal
  (based_base) @type.builtin
  (based_integer) @number)

(based_literal
  (based_base) @type.builtin
  (based_float) @number.float)

(string_literal) @string @spell

(character_literal) @character

(library_constant_std_logic) @constant.builtin

(library_constant) @constant.builtin

(library_function) @function.builtin

(library_constant_boolean) @boolean

(library_constant_character) @character

(library_constant_debug) @keyword.debug

(unit) @keyword.modifier

(library_constant_unit) @keyword.modifier

(label) @label

(generic_map_aspect
  "generic" @constructor
  "map" @constructor)

(port_map_aspect
  "port" @constructor
  "map" @constructor)

(selection
  (identifier) @variable.member)

(_
  view: (_) @type)

(_
  type: (_) @type)

(_
  library: (_) @module)

(_
  package: (_) @module)

(_
  entity: (_) @module)

(_
  component: (_) @module)

(_
  configuration: (_) @property)

(_
  architecture: (_) @property)

(_
  function: (_) @function)

(_
  procedure: (_) @function.method)

(_
  attribute: (_) @attribute)

(_
  constant: (_) @constant)

(_
  generic: (_) @variable.parameter)

(_
  view: (name
    (_)) @type)

(_
  type: (name
    (_)) @type)

(_
  entity: (name
    (_)) @module)

(_
  component: (name
    (_)) @module)

(_
  configuration: (name
    (_)) @module)

(library_type) @type.builtin

[
  (attribute_function)
  (attribute_impure_function)
  (attribute_mode_view)
  (attribute_pure_function)
  (attribute_range)
  (attribute_signal)
  (attribute_subtype)
  (attribute_type)
  (attribute_value)
  (library_attribute)
] @attribute.builtin

(library_namespace) @module.builtin

(subtype_declaration
  (identifier) @type.definition)

(type_declaration
  (identifier) @type.definition)

(mode_view_declaration
  (identifier) @type.definition)
