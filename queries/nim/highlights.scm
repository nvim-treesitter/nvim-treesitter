; SPDX-FileCopyrightText: 2023 Leorize <leorize+oss@disroot.org>, aMOPel <>
; SPDX-License-Identifier: MPL-2.0
; SPDX-License-Identifier: Apache-2.0

; =============================================================================
; catch all rules

((identifier) @variable (#set! "priority" 95))

; =============================================================================
; @comment               ; line and block comments

[
  (comment)
  (block_comment)
] @comment

; =============================================================================
; @comment.documentation ; comments documenting code

[
  (documentation_comment)
  (block_documentation_comment)
] @comment.documentation

; =============================================================================
; @none                  ; completely disable the highlight
; unused

; =============================================================================
; @preproc               ; various preprocessor directives & shebangs

(pragma_list ["{." "}" ".}"] @preproc)

; =============================================================================
; @define                ; preprocessor definition directives
; unused

; =============================================================================
; @operator              ; symbolic operators (e.g. `+` / `*`)

(operator) @operator

; =============================================================================
; @punctuation.delimiter ; delimiters (e.g. `;` / `.` / `,`)

[ "." ";" "," ":" "=" ] @punctuation.delimiter

; needs to be after @punctuation.delimiter
(assignment "=" @operator)

; =============================================================================
; @punctuation.bracket   ; brackets (e.g. `()` / `{}` / `[]`)

[ "(" ")" "[" "[:" "]" "{" "}" ] @punctuation.bracket

; =============================================================================
; @punctuation.special   ; special symbols (e.g. `{}` in string interpolation)

(accent_quoted "`" @punctuation.special)

(exported_symbol "*" @punctuation.special)

; dereference operator
(bracket_expression !right "[" @punctuation.special . "]" @punctuation.special)

; =============================================================================
; @string               ; string literals

(string_literal) @string

; =============================================================================
; @string.documentation ; string documenting code (e.g. Python docstrings)
; unused

; =============================================================================
; @string.regex         ; regular expressions
; unused

; =============================================================================
; @string.escape        ; escape sequences

(escape_sequence) @string.escape

; =============================================================================
; @string.special       ; other special strings (e.g. dates)
; unused

; =============================================================================
; @character            ; character literals

(char_literal) @character

; =============================================================================
; @character.special    ; special characters (e.g. wildcards)
; unused

; =============================================================================
; @boolean              ; boolean literals

((identifier) @boolean
  (#any-of? @boolean "true" "false" "on" "off"))

; =============================================================================
; @number               ; numeric literals

(integer_literal) @number

(custom_numeric_literal) @number

; =============================================================================
; @float                ; floating-point number literals

(float_literal) @float

; =============================================================================
; @function         ; function definitions

(proc_declaration
  name: [
    (identifier) @function
    (accent_quoted (identifier) @function)
    (exported_symbol (identifier) @function)
    (exported_symbol (accent_quoted (identifier) @function))
  ])

(func_declaration
  name: [
    (identifier) @function
    (accent_quoted (identifier) @function)
    (exported_symbol (identifier) @function)
    (exported_symbol (accent_quoted (identifier) @function))
  ])

(iterator_declaration
  name: [
    (identifier) @function
    (accent_quoted (identifier) @function)
    (exported_symbol (identifier) @function)
    (exported_symbol (accent_quoted (identifier) @function))
  ])

(converter_declaration
  name: [
    (identifier) @function
    (accent_quoted (identifier) @function)
    (exported_symbol (identifier) @function)
    (exported_symbol (accent_quoted (identifier) @function))
  ])

; =============================================================================
; @function.call    ; function calls

(call
  function: [
    (identifier) @function.call
    (accent_quoted (identifier) @function.call)
    ; generic types
    (bracket_expression left: (identifier) @function.call)
    (bracket_expression left: (accent_quoted (identifier) @function.call))
    ; dot accessor
    (dot_expression right: (identifier) @function.call)
    (dot_expression right: (accent_quoted (identifier) @function.call))
    ; both
    (bracket_expression left:
      (dot_expression right: (identifier) @function.call))
    (bracket_expression left:
      (dot_expression right: (accent_quoted (identifier) @function.call)))
  ])

; generalized_string is a function call
; `identifier"string literal"`
; is short for
; `identifier(r"string literal")`
(generalized_string . [
  (identifier) @function.call
  (accent_quoted (identifier) @function.call)
])

; =============================================================================
; @function.builtin ; built-in functions
; unused

; =============================================================================
; @function.macro   ; preprocessor macros

(template_declaration
  name: [
    (identifier) @function
    (accent_quoted (identifier) @function)
    (exported_symbol (identifier) @function)
    (exported_symbol (accent_quoted (identifier) @function))
  ])

(macro_declaration
  name: [
    (identifier) @function
    (accent_quoted (identifier) @function)
    (exported_symbol (identifier) @function)
    (exported_symbol (accent_quoted (identifier) @function))
  ])

; =============================================================================
; @method           ; method definitions

(method_declaration
  name: [
    (identifier) @method
    (accent_quoted (identifier) @method)
    (exported_symbol (identifier) @method)
    (exported_symbol (accent_quoted (identifier) @method))
  ])

; =============================================================================
; @method.call      ; method calls
; unused

; =============================================================================
; @constructor      ; constructor calls and definitions

(call
  function: [
    (identifier) @constructor
    (accent_quoted (identifier) @constructor)
    ; generic types
    (bracket_expression left: (identifier) @constructor)
    (bracket_expression left: (accent_quoted (identifier) @constructor))
    ; dot accessor
    (dot_expression right: (identifier) @constructor)
    (dot_expression right: (accent_quoted (identifier) @constructor))
    ; both
    (bracket_expression left:
      (dot_expression right: (identifier) @constructor))
    (bracket_expression left:
      (dot_expression right: (accent_quoted (identifier) @constructor)))
  ]
  (argument_list
    (colon_expression)+))
; NOTE: this cannot detect constructors with 0 arguments
; those will be matched as @function.call instead

; =============================================================================
; @parameter        ; parameters of a function

; named parameters when calling
; call(parameter_name=arg)
(argument_list
  (equal_expression
    left: [
      (identifier) @parameter
      (accent_quoted (identifier) @parameter)
    ]))

; parameters in function declaration
(parameter_declaration_list
  (parameter_declaration
    (symbol_declaration_list
      (symbol_declaration
        name: [
          (identifier) @parameter
          (accent_quoted (identifier) @parameter)
        ]))))

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
; @keyword.coroutine   ; keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
; unused

; =============================================================================
; @keyword.function    ; keywords that define a function (e.g. `func` in Go, `def` in Python)

[
  "proc"
  "func"
  "method"
  "converter"
  "iterator"
  "macro"
  "template"
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
; @conditional         ; keywords related to conditionals (e.g. `if` / `else`)

[
  "if"
  "when"
  "case"
  "elif"
  "else"
] @conditional

(of_branch "of" @conditional)

; =============================================================================
; @conditional.ternary ; ternary operator (e.g. `?` / `:`)

; =============================================================================
; @repeat              ; keywords related to loops (e.g. `for` / `while`)

[
  "for"
  "while"
  "continue"
  "break"
] @repeat

(for "in" @repeat)

; =============================================================================
; @debug               ; keywords related to debugging
; unused

; =============================================================================
; @label               ; GOTO and other labels (e.g. `label:` in C)

(block
  label: [
    (identifier) @label
    (accent_quoted (identifier) @label)
  ])

; =============================================================================
; @include             ; keywords for including modules (e.g. `import` / `from` in Python)

[
  "import"
  "include"
  "export"
] @include

(import_from_statement "from" @include)

(except_clause "except" @include)

; =============================================================================
; @exception           ; keywords related to exceptions (e.g. `throw` / `catch`)

[
  "try"
  "except"
  "finally"
  "raise"
] @exception

; =============================================================================
; @type            ; type or class definitions and annotations

((identifier) @type
  (#has-ancestor? @type type_expression)
  (#not-has-ancestor? @type pragma_list)
  (#set! "priority" 98) ; for parameters in proc_type
  )
; NOTE: benchmarked with
; `$ hyperfine -P version 1 3 "tree-sitter query -q $QUERIES/highlights{version}.scm $NIM_REPO/**/*.nim"`
; with
; 1. "no-priority" version,
; 2. "priority and (_ (_ (_... nesting version" and
; 3. "priority and has-ancestor version".
; "no-priority" was the worst, the other two were almost the same,
; but "has-ancestor" is superior, since it allows for infinite nesting.


; generic types when declaring
((generic_parameter_list
  (parameter_declaration
    (symbol_declaration_list
      (symbol_declaration
        name: [
          (identifier) @type
          (accent_quoted (identifier) @type)
        ])))))

; generic types when calling
(call
  function: (bracket_expression
    right: (argument_list [
      (identifier) @type
      (_ (identifier) @type)
      (_ (_ (identifier) @type))
      (_ (_ (_ (identifier) @type)))
      (_ (_ (_ (_ (identifier) @type))))
      (_ (_ (_ (_ (_ (identifier) @type)))))
      (_ (_ (_ (_ (_ (_ (identifier) @type))))))
      (_ (_ (_ (_ (_ (_ (_ (identifier) @type)))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @type))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @type)))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @type))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @type)))))))))))
      (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @type))))))))))))
    ])))
; NOTE: this also falsely matches
; when accessing and directly call elements from an array of routines
; eg `array_of_routines[index](arguments), but that is an uncommon case

; left side of type declaration
(type_symbol_declaration
  name: [
    (identifier) @type
    (accent_quoted (identifier) @type)
    (exported_symbol (identifier) @type)
    (exported_symbol (accent_quoted (identifier) @type))
  ])

; right side of `is` operator is always type
(infix_expression
  operator: [ "is" "isnot" ]
  right: [
    (identifier) @type
    (_ (identifier) @type)
    (_ (_ (identifier) @type))
    (_ (_ (_ (identifier) @type)))
    (_ (_ (_ (_ (identifier) @type))))
    (_ (_ (_ (_ (_ (identifier) @type)))))
    (_ (_ (_ (_ (_ (_ (identifier) @type))))))
    (_ (_ (_ (_ (_ (_ (_ (identifier) @type)))))))
    (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @type))))))))
    (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @type)))))))))
    (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @type))))))))))
    (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @type)))))))))))
    (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @type))))))))))))
  ])

; except branch always contains types of errors
; Eg: `except module.exception[gen_type]:`
; Or `except module.exception[gen_type] as variable:`
(except_branch
  values: (expression_list [
    (identifier) @type
    (accent_quoted (identifier) @type)
    (infix_expression
      left: [
        (identifier) @type
        (_ (identifier) @type)
        (_ (_ (identifier) @type))
        (_ (_ (_ (identifier) @type)))
        (_ (_ (_ (_ (identifier) @type))))
        (_ (_ (_ (_ (_ (identifier) @type)))))
        (_ (_ (_ (_ (_ (_ (identifier) @type))))))
        (_ (_ (_ (_ (_ (_ (_ (identifier) @type)))))))
        (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @type))))))))
        (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @type)))))))))
        (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @type))))))))))
        (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @type)))))))))))
        (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (_ (identifier) @type))))))))))))
      ]
      operator: "as")
  ]))

; for inline tuple types
; `type a = tuple[a: int]`
(tuple_type
  "tuple" @type
  (field_declaration_list))
; NOTE: this is consistent with other generic types like `seq[int]`
; but inconsistent with multiline tuple declaration,
; where `tuple` is captured as @keyword

; =============================================================================
; @type.builtin    ; built-in types
; unused

; =============================================================================
; @type.definition ; type definitions (e.g. `typedef` in C)

(type_section ("type") @type.definition)

; =============================================================================
; @type.qualifier  ; type qualifiers (e.g. `const`)

(var_type "var" @type.qualifier)

(out_type "out" @type.qualifier)

(distinct_type "distinct" @type.qualifier)

(ref_type "ref" @type.qualifier)

(pointer_type "ptr" @type.qualifier)

; =============================================================================
; @storageclass    ; modifiers that affect storage in memory or life-time
; unused

; =============================================================================
; @attribute       ; attribute annotations (e.g. Python decorators)
; unused

; =============================================================================
; @field           ; object and struct fields

; fields in object/tuple declaration
(field_declaration
  (symbol_declaration_list
    (symbol_declaration
      name: [
        (identifier) @field
        (accent_quoted (identifier) @field)
        (exported_symbol (identifier) @field)
        (exported_symbol (accent_quoted (identifier) @field))
      ])))

; fields in object construction
(call
  (argument_list
    (colon_expression
      left: [
        (identifier) @field
        (accent_quoted (identifier) @field)
      ])))

; fields in tuple construction
(tuple_construction
  (colon_expression
    left: [
      (identifier) @field
      (accent_quoted (identifier) @field)
    ]))

; =============================================================================
; @property        ; similar to `@field`
; unused

; =============================================================================
; @variable         ; various variable names

; =============================================================================
; @variable.builtin ; built-in variable names (e.g. `this`)

(blank_identifier) @variable.builtin

((identifier) @variable.builtin
  (#eq? @variable.builtin "result"))

; =============================================================================
; @constant         ; constant identifiers

; identifiers in "case" "of" branches have to be enums
(case
  (of_branch values:
    (expression_list [
      (identifier) @constant
      (_ (identifier) @constant)
      (_ (_ (identifier) @constant))
      (_ (_ (_ (identifier) @constant)))
      (_ (_ (_ (_ (identifier) @constant))))
      (_ (_ (_ (_ (_ (identifier) @constant)))))
      (_ (_ (_ (_ (_ (_ (identifier) @constant))))))
    ])))

; in variant objects with "case" "of"
(variant_declaration
  (of_branch values:
    (expression_list [
      (identifier) @constant
      (_ (identifier) @constant)
      (_ (_ (identifier) @constant))
      (_ (_ (_ (identifier) @constant)))
      (_ (_ (_ (_ (identifier) @constant))))
      (_ (_ (_ (_ (_ (identifier) @constant)))))
      (_ (_ (_ (_ (_ (_ (identifier) @constant))))))
    ])))

; enum declaration
(enum_field_declaration
  (symbol_declaration
    name: [
      (identifier) @constant
      (accent_quoted (identifier) @constant)
    ]))

; constants/enums in array construction
(array_construction
  (colon_expression
    left: [
      (identifier) @constant
      (_ (identifier) @constant)
      (_ (_ (identifier) @constant))
      (_ (_ (_ (identifier) @constant)))
      (_ (_ (_ (_ (identifier) @constant))))
      (_ (_ (_ (_ (_ (identifier) @constant)))))
      (_ (_ (_ (_ (_ (_ (identifier) @constant))))))
    ]))

; constant declaration
(const_section
  (variable_declaration
    (symbol_declaration_list
      (symbol_declaration
        name: [
          (identifier) @constant
          (accent_quoted (identifier) @constant)
          (exported_symbol (identifier) @constant)
          (exported_symbol (accent_quoted (identifier) @constant))
        ]))))

; =============================================================================
; @constant.builtin ; built-in constant values

(nil_literal) @constant.builtin

; =============================================================================
; @constant.macro   ; constants defined by the preprocessor
; unused

; =============================================================================
; @namespace        ; modules or namespaces
; unused

; =============================================================================
; @symbol           ; symbols or atoms
; unused

; =============================================================================
; overrule things

; left identifier in dot_expression
(dot_expression left: [
  (identifier) @none
  (accent_quoted (identifier) @none)
] (#set! "priority" 110))
; NOTE: it can't be know what the left identifier is, so better leave it alone
; for consistency

; =============================================================================
; @error                 ; syntax/parser errors

(ERROR) @error
