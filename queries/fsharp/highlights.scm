[
  (line_comment)
  (block_comment)
] @comment @spell

((line_comment) @comment.documentation @spell
  (#lua-match? @comment.documentation "^///"))

(const
  [
    (_) @constant
    (unit) @constant.builtin
  ])

(primary_constr_args
  (_) @variable.parameter)

(class_as_reference
  (_) @variable.parameter.builtin)

((argument_patterns
  (long_identifier
    (identifier) @character.special))
  (#lua-match? @character.special "^\_.*"))

(wildcard_pattern) @character.special

(type_name
  type_name: (_) @type.definition)

[
  (_type)
  (atomic_type)
] @type

(member_signature
  .
  (identifier) @function.method
  (curried_spec
    (arguments_spec
      "*"* @operator
      (argument_spec
        (argument_name_spec
          "?"? @character.special
          name: (_) @variable.parameter)))))

(union_type_case) @constant

(rules
  (rule
    pattern: (_) @constant
    block: (_)))

(identifier_pattern
  .
  (_) @constant
  .
  (_) @variable)

(optional_pattern
  "?" @character.special)

(fsi_directive_decl
  .
  (string) @module)

(import_decl
  .
  (_) @module)

(named_module
  name: (_) @module)

(namespace
  name: (_) @module)

(module_defn
  .
  (_) @module)

(ce_expression
  .
  (_) @constant.macro)

(field_initializer
  field: (_) @property)

(record_fields
  (record_field
    .
    (identifier) @property))

(dot_expression
  base: (_)? @module)

(value_declaration_left
  .
  (_) @variable)

(function_declaration_left
  .
  (_) @function
  .
  (_)* @variable.parameter)

(member_defn
  (method_or_prop_defn
    [
      (property_or_ident) @function
      (property_or_ident
        instance: (identifier) @variable.parameter.builtin
        method: (identifier) @function.method)
    ]
    args: (_)* @variable.parameter))

(application_expression
  .
  (_) @function.call
  .
  (_) @variable)

((infix_expression
  .
  (_)
  .
  (infix_op) @operator
  .
  (_) @function.call)
  (#eq? @operator "|>"))

((infix_expression
  .
  (_) @function.call
  .
  (infix_op) @operator
  .
  (_))
  (#eq? @operator "<|"))

[
  (xint)
  (int)
  (int16)
  (uint16)
  (int32)
  (uint32)
  (int64)
  (uint64)
  (nativeint)
  (unativeint)
] @number

[
  (ieee32)
  (ieee64)
  (float)
  (decimal)
] @number.float

(bool) @boolean

[
  (string)
  (triple_quoted_string)
  (verbatim_string)
  (char)
] @spell @string

(compiler_directive_decl) @keyword.directive

(preproc_line
  "#line" @keyword.directive)

(attribute) @attribute

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
  "[|"
  "|]"
  "{|"
  "|}"
] @punctuation.bracket

[
  "[<"
  ">]"
] @punctuation.special

(format_string_eval
  [
    "{"
    "}"
  ] @punctuation.special)

[
  ","
  ";"
] @punctuation.delimiter

[
  "|"
  "="
  ">"
  "<"
  "-"
  "~"
  "->"
  "<-"
  "&&"
  "||"
  ":>"
  ":?>"
  (infix_op)
  (prefix_op)
] @operator

[
  "if"
  "then"
  "else"
  "elif"
  "when"
  "match"
  "match!"
] @keyword.conditional

[
  "and"
  "or"
  "not"
  "upcast"
  "downcast"
] @keyword.operator

[
  "return"
  "return!"
  "yield"
  "yield!"
] @keyword.return

[
  "for"
  "while"
  "downto"
  "to"
] @keyword.repeat

[
  "open"
  "#r"
  "#load"
] @keyword.import

[
  "abstract"
  "delegate"
  "static"
  "inline"
  "mutable"
  "override"
  "rec"
  "global"
  (access_modifier)
] @keyword.modifier

[
  "let"
  "let!"
  "use"
  "use!"
  "member"
] @keyword.function

[
  "enum"
  "type"
  "inherit"
  "interface"
  "and"
  "class"
  "struct"
] @keyword.type

((identifier) @keyword.exception
  (#any-of? @keyword.exception "failwith" "failwithf" "raise" "reraise"))

[
  "as"
  "assert"
  "begin"
  "end"
  "done"
  "default"
  "in"
  "do"
  "do!"
  "event"
  "field"
  "fun"
  "function"
  "get"
  "set"
  "lazy"
  "new"
  "of"
  "param"
  "property"
  "struct"
  "val"
  "module"
  "namespace"
  "with"
] @keyword

"null" @constant.builtin

(match_expression
  "with" @keyword.conditional)

(try_expression
  [
    "try"
    "with"
    "finally"
  ] @keyword.exception)

((_type
  (long_identifier
    (identifier) @type.builtin))
  (#any-of? @type.builtin
    "bool" "byte" "sbyte" "int16" "uint16" "int" "uint" "int64" "uint64" "nativeint" "unativeint"
    "decimal" "float" "double" "float32" "single" "char" "string" "unit"))

(preproc_if
  [
    "#if" @keyword.directive
    "#endif" @keyword.directive
  ]
  condition: (_)? @keyword.directive)

(preproc_else
  "#else" @keyword.directive)

(long_identifier
  (identifier)+ @module
  .
  (identifier))

(op_identifier) @operator

((identifier) @module.builtin
  (#any-of? @module.builtin
    "Array" "Async" "Directory" "File" "List" "Option" "Path" "Map" "Set" "Lazy" "Seq" "Task"
    "String" "Result"))

((value_declaration
  (attributes
    (attribute
      (_type
        (long_identifier
          (identifier) @attribute))))
  (function_or_value_defn
    (value_declaration_left
      .
      (_) @constant)))
  (#eq? @attribute "Literal"))
