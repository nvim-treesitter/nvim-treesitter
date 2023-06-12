; SPDX-FileCopyrightText: 2023 Leorize <leorize+oss@disroot.org>, aMOPel <>
; SPDX-License-Identifier: MPL-2.0
; SPDX-License-Identifier: Apache-2.0
; =============================================================================
; catch all rules
((identifier) @variable
  (#set! "priority" 99))

; NOTE: we need priority, since (identifier) is most specific and we have to
; capture nodes containing (identifier) as a whole, while overruling the
; @variable capture.
(type_expression) @type

; NOTE: has to be after
; ((identifier) @variable (#set! "priority" 99))
; overrule identifiers in pragmas in (proc_type)s and (pragma_expression)s
(proc_type
  pragmas: (pragma_list) @variable)

(iterator_type
  pragmas: (pragma_list) @variable)

(type_expression
  (pragma_expression
    right: (pragma_list) @variable))

; NOTE: has to be after
; (type_expression) @type
; and before @keyword.directive and all literals
; constants/enums in array construction
(array_construction
  (colon_expression
    left: (_) @constant))

; NOTE: has to be before literals and punctuation etc.
; identifiers in "case" "of" branches have to be enums
(case
  alternative: (of_branch
    values: (expression_list
      (_) @constant)))

; NOTE: has to be before literals and punctuation etc.
; in variant objects with "case" "of"
(variant_declaration
  alternative: (of_branch
    values: (expression_list
      (_) @constant)))

; NOTE: has to be before literals and punctuation etc.
; =============================================================================
; @comment               ; line and block comments
[
  (comment)
  (block_comment)
] @comment

; =============================================================================
; @comment.documentation ; comments documenting code
(documentation_comment
  "##" @comment.documentation)

(block_documentation_comment
  "##[" @comment.documentation
  "]##" @comment.documentation)

; NOTE: leaving content uncaptured so markdown can be injected
; =============================================================================
; @punctuation.delimiter ; delimiters (e.g. `;` / `.` / `,`)
[
  "."
  ";"
  ","
  ":"
  "="
] @punctuation.delimiter

; =============================================================================
; @operator              ; symbolic operators (e.g. `+` / `*`)
(operator) @operator

(assignment
  "=" @operator)

; =============================================================================
; @punctuation.bracket   ; brackets (e.g. `()` / `{}` / `[]`)
[
  "("
  ")"
  "["
  "[:"
  "]"
  "{"
  "}"
] @punctuation.bracket

; =============================================================================
; @keyword.directive               ; various preprocessor directives & shebangs
[
  "macro"
  "template"
] @keyword.directive

(pragma_list
  [
    "{."
    "}"
    ".}"
  ] @keyword.directive)

; NOTE: has to come after @punctuation.bracket
; =============================================================================
; @punctuation.special   ; special symbols (e.g. `{}` in string interpolation)
(accent_quoted
  "`" @punctuation.special)

(exported_symbol
  "*" @punctuation.special)

; dereference operator
(bracket_expression
  !right
  "[" @punctuation.special
  .
  "]" @punctuation.special)

; =============================================================================
; @string               ; string literals
[
  (interpreted_string_literal)
  (long_string_literal)
  (raw_string_literal)
  (generalized_string)
] @string

; injections in generalized_strings
(generalized_string
  (string_content) @none)

; format string injection in normal strings with & prefix
(prefix_expression
  operator: (operator) @_string_prefix
  .
  (_
    (string_content) @none)
  (#eq? @_string_prefix "&"))

; emit pragma injection
(pragma_statement
  (pragma_list
    (colon_expression
      left: (identifier) @_emit_keyword
      (#eq? @_emit_keyword "emit")
      right: (_
        (string_content) @none))))

; =============================================================================
; @string.escape        ; escape sequences
(escape_sequence) @string.escape

; =============================================================================
; @character            ; character literals
(char_literal) @character

; =============================================================================
; @boolean              ; boolean literals
((identifier) @boolean
  (#any-of? @boolean "true" "false" "on" "off"))

; =============================================================================
; @number               ; numeric literals
(integer_literal) @number

(custom_numeric_literal) @number

; =============================================================================
; @number.float                ; floating-point number literals
(float_literal) @number.float

; =============================================================================
; @function         ; function definitions
(proc_declaration
  name: [
    (identifier) @function
    (accent_quoted
      (identifier) @function)
    (exported_symbol
      (identifier) @function)
    (exported_symbol
      (accent_quoted
        (identifier) @function))
  ])

(func_declaration
  name: [
    (identifier) @function
    (accent_quoted
      (identifier) @function)
    (exported_symbol
      (identifier) @function)
    (exported_symbol
      (accent_quoted
        (identifier) @function))
  ])

(iterator_declaration
  name: [
    (identifier) @function
    (accent_quoted
      (identifier) @function)
    (exported_symbol
      (identifier) @function)
    (exported_symbol
      (accent_quoted
        (identifier) @function))
  ])

(converter_declaration
  name: [
    (identifier) @function
    (accent_quoted
      (identifier) @function)
    (exported_symbol
      (identifier) @function)
    (exported_symbol
      (accent_quoted
        (identifier) @function))
  ])

; =============================================================================
; @function.call    ; function calls
(call
  function: [
    (identifier) @function.call
    (accent_quoted
      (identifier) @function.call)
    ; generic types
    (bracket_expression
      left: (identifier) @function.call)
    (bracket_expression
      left: (accent_quoted
        (identifier) @function.call))
    ; dot accessor
    (dot_expression
      right: (identifier) @function.call)
    (dot_expression
      right: (accent_quoted
        (identifier) @function.call))
    ; both
    (bracket_expression
      left: (dot_expression
        right: (identifier) @function.call))
    (bracket_expression
      left: (dot_expression
        right: (accent_quoted
          (identifier) @function.call)))
  ])

(dot_generic_call
  function: [
    (identifier) @function.call
    (accent_quoted
      (identifier) @function.call)
  ])

; generalized_string is a function call
; `identifier"string literal"`
; is short for
; `identifier(r"string literal")`
(generalized_string
  function: [
    (identifier) @function.call
    (accent_quoted
      (identifier) @function.call)
  ])

; call with leading literal
(dot_expression
  left: [
    (nil_literal)
    (integer_literal)
    (float_literal)
    (custom_numeric_literal)
    (char_literal)
    (interpreted_string_literal)
    (long_string_literal)
    (raw_string_literal)
    (generalized_string)
    (array_construction)
    ; for sequences
    (prefix_expression
      operator: (operator) @_at
      (array_construction)
      (#eq? @_at "@"))
    (tuple_construction)
    (curly_construction)
  ]
  right: [
    (identifier) @function.call
    (accent_quoted
      (identifier) @function.call)
  ])

; NOTE: will double capture as @function.call if it also has argument_list
; function.calls in `varargs[type, routine]`
(bracket_expression
  left: (identifier) @_varargs
  right: (argument_list
    .
    (_)
    .
    [
      (identifier) @function.call
      (accent_quoted
        (identifier) @function.call)
      (dot_expression
        right: (identifier) @function.call)
      (dot_expression
        right: (accent_quoted
          (identifier) @function.call))
    ])
  (#eq? @_varargs "varargs"))

; =============================================================================
; @function.macro   ; preprocessor macros
(template_declaration
  name: [
    (identifier) @function.macro
    (accent_quoted
      (identifier) @function.macro)
    (exported_symbol
      (identifier) @function.macro)
    (exported_symbol
      (accent_quoted
        (identifier) @function.macro))
  ])

(macro_declaration
  name: [
    (identifier) @function.macro
    (accent_quoted
      (identifier) @function.macro)
    (exported_symbol
      (identifier) @function.macro)
    (exported_symbol
      (accent_quoted
        (identifier) @function.macro))
  ])

; =============================================================================
; @function.method           ; method definitions
(method_declaration
  name: [
    (identifier) @function.method
    (accent_quoted
      (identifier) @function.method)
    (exported_symbol
      (identifier) @function.method)
    (exported_symbol
      (accent_quoted
        (identifier) @function.method))
  ])

; =============================================================================
; @constructor      ; constructor calls and definitions
(call
  function: [
    (identifier) @constructor
    (accent_quoted
      (identifier) @constructor)
    ; generic types
    (bracket_expression
      left: (identifier) @constructor)
    (bracket_expression
      left: (accent_quoted
        (identifier) @constructor))
    ; dot accessor
    (dot_expression
      right: (identifier) @constructor)
    (dot_expression
      right: (accent_quoted
        (identifier) @constructor))
    ; both
    (bracket_expression
      left: (dot_expression
        right: (identifier) @constructor))
    (bracket_expression
      left: (dot_expression
        right: (accent_quoted
          (identifier) @constructor)))
  ]
  (argument_list
    (colon_expression)+))

; NOTE: this cannot detect constructors with 0 arguments
; those will be matched as @function.call instead
; =============================================================================
; @keyword             ; various keywords
; unhandled but reserved keywords
; end
; interface
; static expression
; addr operator
((call
  function: (identifier) @keyword)
  (#any-of? @keyword "static" "addr"))

[
  "const"
  "let"
  "var"
  "type"
  "concept"
  "asm"
  "bind"
  "defer"
  "do"
  "mixin"
  "static"
  "object"
  "tuple"
  "enum"
  "block"
  "using"
  "discard"
] @keyword

; =============================================================================
; @keyword.function    ; keywords that define a function (e.g. `func` in Go, `def` in Python)
[
  "proc"
  "func"
  "method"
  "converter"
  "iterator"
] @keyword.function

; =============================================================================
; @keyword.operator    ; operators that are English words (e.g. `and` / `or`)
[
  "and"
  "or"
  "xor"
  "not"
  "div"
  "mod"
  "shl"
  "shr"
  "from"
  "as"
  "of"
  "in"
  "notin"
  "is"
  "isnot"
  "cast"
] @keyword.operator

; =============================================================================
; @keyword.return      ; keywords like `return` and `yield`
[
  "return"
  "yield"
] @keyword.return

; =============================================================================
; @keyword.conditional         ; keywords related to conditionals (e.g. `if` / `else`)
[
  "if"
  "when"
  "case"
  "elif"
  "else"
] @keyword.conditional

(of_branch
  "of" @keyword.conditional)

; =============================================================================
; @keyword.repeat              ; keywords related to loops (e.g. `for` / `while`)
[
  "for"
  "while"
  "continue"
  "break"
] @keyword.repeat

(for
  "in" @keyword.repeat)

; =============================================================================
; @label               ; GOTO and other labels (e.g. `label:` in C)
(block
  label: [
    (identifier) @label
    (accent_quoted
      (identifier) @label)
  ])

; =============================================================================
; @keyword.import             ; keywords for including modules (e.g. `import` / `from` in Python)
[
  "import"
  "include"
  "export"
] @keyword.import

(import_from_statement
  "from" @keyword.import)

(except_clause
  "except" @keyword.import)

; =============================================================================
; @keyword.exception           ; keywords related to exceptions (e.g. `throw` / `catch`)
[
  "try"
  "except"
  "finally"
  "raise"
] @keyword.exception

; =============================================================================
; @type            ; type or class definitions and annotations
; generic types when calling
(call
  function: (bracket_expression
    right: (argument_list) @type))

; NOTE: this also falsely matches
; when accessing and directly call elements from an array of routines
; eg `array_of_routines[index](arguments), but that is an uncommon case
; dot_generic_call `v.call[:type, type]()
(dot_generic_call
  generic_arguments: (_) @type)

; right side of `is` operator is always type
(infix_expression
  operator: [
    "is"
    "isnot"
  ]
  right: (_) @type)

; except branch always contains types of errors
; Eg: `except module.exception[gen_type]:`
(except_branch
  values: (expression_list) @type)

; overrule special case in (except_branch) with "as" operator
; `except module.exception[gen_type] as variable:`
(except_branch
  values: (expression_list
    (infix_expression
      operator: "as"
      right: [
        (identifier) @variable
        (accent_quoted
          (identifier) @variable)
      ])))

; for inline tuple types
; `type a = tuple[a: int]`
(tuple_type
  "tuple" @type
  (field_declaration_list))

; NOTE: this is consistent with other generic types like `seq[int]`
; but inconsistent with multiline tuple declaration,
; where `tuple` is captured as @keyword
; =============================================================================
; @variable.parameter        ; parameters of a function
; named parameters when calling
; call(parameter_name=arg)
(argument_list
  (equal_expression
    left: [
      (identifier) @variable.parameter
      (accent_quoted
        (identifier) @variable.parameter)
    ]))

; parameters in function declaration
(parameter_declaration_list
  (parameter_declaration
    (symbol_declaration_list
      (symbol_declaration
        name: [
          (identifier) @variable.parameter
          (accent_quoted
            (identifier) @variable.parameter)
        ]))))

; NOTE: needs to be after @type
; generic types when declaring
(generic_parameter_list
  (parameter_declaration
    (symbol_declaration_list
      (symbol_declaration
        name: [
          (identifier) @variable.parameter
          (accent_quoted
            (identifier) @variable.parameter)
        ]))))

; for loop variables
(for
  left: (symbol_declaration_list
    (symbol_declaration
      name: [
        (identifier) @variable.parameter
        (accent_quoted
          (identifier) @variable.parameter)
      ])))

((tuple_deconstruct_declaration
  (symbol_declaration
    name: [
      (identifier) @variable.parameter
      (accent_quoted
        (identifier) @variable.parameter)
    ])) @_tuple_decons
  (#has-ancestor? @_tuple_decons for))

(concept_declaration
  parameters: (parameter_list
    [
      (identifier) @variable.parameter
      (accent_quoted
        (identifier) @variable.parameter)
    ]))

(var_parameter
  [
    (identifier) @variable.parameter
    (accent_quoted
      (identifier) @variable.parameter)
  ])

(type_parameter
  [
    (identifier) @variable.parameter
    (accent_quoted
      (identifier) @variable.parameter)
  ])

(static_parameter
  [
    (identifier) @variable.parameter
    (accent_quoted
      (identifier) @variable.parameter)
  ])

(ref_parameter
  [
    (identifier) @variable.parameter
    (accent_quoted
      (identifier) @variable.parameter)
  ])

(pointer_parameter
  [
    (identifier) @variable.parameter
    (accent_quoted
      (identifier) @variable.parameter)
  ])

; =============================================================================
; @type.definition ; type definitions (e.g. `typedef` in C)
(type_section
  (type_declaration
    (type_symbol_declaration
      name: [
        (identifier) @type.definition
        (accent_quoted
          (identifier) @type.definition)
        (exported_symbol
          (identifier) @type.definition)
        (exported_symbol
          (accent_quoted
            (identifier) @type.definition))
      ])))

; =============================================================================
; @keyword.modifier  ; type qualifier keywords (e.g. `const`)
(var_type
  "var" @keyword.modifier)

(out_type
  "out" @keyword.modifier)

(distinct_type
  "distinct" @keyword.modifier)

(ref_type
  "ref" @keyword.modifier)

(pointer_type
  "ptr" @keyword.modifier)

(var_parameter
  "var" @keyword.modifier)

(type_parameter
  "type" @keyword.modifier)

(static_parameter
  "static" @keyword.modifier)

(ref_parameter
  "ref" @keyword.modifier)

(pointer_parameter
  "ptr" @keyword.modifier)

; =============================================================================
; @variable.member           ; object and struct fields
; fields in object/tuple declaration
(field_declaration
  (symbol_declaration_list
    (symbol_declaration
      name: [
        (identifier) @variable.member
        (accent_quoted
          (identifier) @variable.member)
        (exported_symbol
          (identifier) @variable.member)
        (exported_symbol
          (accent_quoted
            (identifier) @variable.member))
      ])))

; fields in object construction
(call
  (argument_list
    (colon_expression
      left: [
        (identifier) @variable.member
        (accent_quoted
          (identifier) @variable.member)
      ])))

; fields in tuple construction
(tuple_construction
  (colon_expression
    left: [
      (identifier) @variable.member
      (accent_quoted
        (identifier) @variable.member)
    ]))

(variant_declaration
  (variant_discriminator_declaration
    (symbol_declaration_list
      (symbol_declaration
        name: [
          (identifier) @variable.member
          (accent_quoted
            (identifier) @variable.member)
          (exported_symbol
            (identifier) @variable.member)
          (exported_symbol
            (accent_quoted
              (identifier) @variable.member))
        ]))))

; =============================================================================
; @variable.builtin ; built-in variable names (e.g. `this`)
(blank_identifier) @variable.builtin

((identifier) @variable.builtin
  (#eq? @variable.builtin "result"))

; NOTE: technically needs `has-ancestor some routine declaration` but it's
; not worth it
; =============================================================================
; @constant         ; constant identifiers
; enum declaration
(enum_field_declaration
  (symbol_declaration
    name: [
      (identifier) @constant
      (accent_quoted
        (identifier) @constant)
    ]))

; constant declaration
(const_section
  (variable_declaration
    (symbol_declaration_list
      (symbol_declaration
        name: [
          (identifier) @constant
          (accent_quoted
            (identifier) @constant)
          (exported_symbol
            (identifier) @constant)
          (exported_symbol
            (accent_quoted
              (identifier) @constant))
        ]))))

((tuple_deconstruct_declaration
  (symbol_declaration
    name: [
      (identifier) @constant
      (accent_quoted
        (identifier) @constant)
      (exported_symbol
        (identifier) @constant)
      (exported_symbol
        (accent_quoted
          (identifier) @constant))
    ])) @_tuple_decons
  (#has-ancestor? @_tuple_decons const_section))

; constants x and y in `array[x..y, type]`
(bracket_expression
  left: (identifier) @_array
  right: (argument_list
    .
    (infix_expression
      right: [
        (identifier) @constant
        (accent_quoted
          (identifier) @constant)
        (dot_expression
          right: (identifier) @constant)
        (dot_expression
          right: (accent_quoted
            (identifier) @constant))
      ]))
  (#any-of? @_array "array" "range"))

(bracket_expression
  left: (identifier) @_array
  right: (argument_list
    .
    (infix_expression
      left: [
        (identifier) @constant
        (accent_quoted
          (identifier) @constant)
        (dot_expression
          right: (identifier) @constant)
        (dot_expression
          right: (accent_quoted
            (identifier) @constant))
      ]))
  (#any-of? @_array "array" "range"))

; NOTE: can only do this for (infix_expression)s, since standalone identifiers
; could be ordinal types and constants
; =============================================================================
; @constant.builtin ; built-in constant values
(nil_literal) @constant.builtin

; =============================================================================
; @module        ; modules or namespaces
(import_statement
  (expression_list
    (identifier) @module))

(import_statement
  (expression_list
    (infix_expression
      operator: "as"
      right: (identifier) @module)))

(import_statement
  (expression_list
    (infix_expression
      operator: (operator) @_operator
      right: [
        (identifier) @module
        (array_construction
          (identifier) @module)
      ]))
  (#eq? @_operator "/"))

(import_from_statement
  module: (infix_expression
    operator: (operator) @_operator
    right: (identifier) @module)
  (#eq? @_operator "/"))

(export_statement
  (expression_list
    (identifier) @module))

; =============================================================================
; overrule things
; left identifier in dot_expression
(dot_expression
  left: [
    (identifier) @none
    (accent_quoted
      (identifier) @none)
  ])

; NOTE: we can't know what the left identifier is, so better leave it alone
; for consistency
; discard literals is like a comment
(discard_statement
  "discard" @comment
  [
    (nil_literal)
    (integer_literal)
    (float_literal)
    (custom_numeric_literal)
    (char_literal)
    (interpreted_string_literal)
    (long_string_literal)
    (raw_string_literal)
    (generalized_string)
    (array_construction)
    ; for sequences
    (prefix_expression
      operator: (operator) @_at
      (array_construction)
      (#eq? @_at "@"))
    (tuple_construction)
    (curly_construction)
  ] @comment)
