(identifier) @variable

((identifier) @variable.builtin
 (#eq? @variable.builtin "context"))

(keyword) @keyword

(operator) @operator
((operator) @conditional
 (#any-of? @conditional
  "in"
  "not_in"
  "or_else"
  "or_return"
 ))

(int_literal)   @number
(float_literal) @number
(rune_literal)  @number
(bool_literal) @boolean
(nil) @constant.builtin

(ERROR) @error

(type_identifier)    @type
(package_identifier) @namespace
(label_identifier)   @label

(interpreted_string_literal) @string @spell
(raw_string_literal) @string @spell
(escape_sequence) @string.escape

(comment) @comment @spell
(const_identifier) @constant

(ternary_expression (operator) @conditional.ternary)

(for_statement (keyword) @repeat)

(proc_literal (keyword) @keyword.function)

(proc_call
  procedure: [
    (identifier) @function.call
    (selector_expression
      field: (identifier) @function.call)])

(proc_call
  procedure: (identifier) @function.builtin
  (#any-of? @function.builtin
    "abs"
    "adjugate"
    "align_of"
    "alloc"
    "append"
    "append_soa"
    "assert"
    "cast"
    "cap"
    "conj"
    "delete"
    "delete_key"
    "determinant"
    "free"
    "free_all"
    "hadamard_product"
    "hermitian_adjoint"
    "imag"
    "inverse"
    "inverse_transpose"
    "jmag"
    "kmag"
    "len"
    "make"
    "matrix_flatten"
    "matrix_minor"
    "matrix_trace"
    "max"
    "min"
    "new"
    "new_clone"
    "outer_product"
    "quaternion"
    "real"
    "realloc"
    "size_of"
    "soa_unzip"
    "soa_zip"
    "swizzle"
    "transpose"
    "type_info_of"
    "type_of"
    "typeid_of"
))

(compound_literal
  type: [
    (pointer_type
      type: (selector_expression
        field: (identifier) @type))
    (selector_expression
      field: (identifier) @type)])

(parameter_declaration
  type: [
    (identifier) @type
    (pointer_type
      type: (selector_expression
        field: (identifier) @type))
    (selector_expression
      field: (identifier) @type)
    (proc_call
      procedure: (identifier) @type)
    (pointer_type
      type: (proc_call
        procedure: (identifier) @type))])

(parameter_declaration
  name: (identifier) @parameter)

(struct_field_declaration
  name: (identifier) @field)

; Types inside result types, like 'type' in '-> Maybe(type)'.
(proc_literal
  result: [
    (proc_call
      (initializer_list [
        (pointer_type
          type: (selector_expression
            field: (identifier) @type))
        (selector_expression
          field: (identifier) @type)
        (identifier) @type]))
    (pointer_type
      type: (selector_expression
        field: (identifier) @type))
    (selector_expression
      field: (identifier) @type)])

; Proc calls in results are types.
(proc_literal
  result: (proc_call
    procedure: (identifier) @type))

; Type declarations inside a struct declaration.
(struct_field_declaration
  type: [
    (pointer_type
      type: (selector_expression
        field: (identifier) @type))
    (selector_expression
      field: (identifier) @type)
    (proc_call
      arguments: (initializer_list[
        (pointer_type
          type: (selector_expression
            field: (identifier) @type))
        (selector_expression
          field: (identifier) @type)
        (identifier) @type]))])

; Variables declared using the ':' operator are types.
(var_declaration
  (operator) @_operator
  type: [
    (pointer_type
      type: (selector_expression
        field: (identifier) @type))
    (selector_expression
      field: (identifier) @type)]
  (#eq? @_operator ":"))

; First argument is a type to these procs.
(proc_call
  procedure: (identifier) @_type_first_proc
  arguments: (initializer_list (identifier)+ @type)
  (#any-of? @_type_first_proc "make" "new"))

; A type assertion like x.(type)
(type_assertion
  type: [
    (pointer_type
      type: (selector_expression
        field: (identifier) @type))
    (selector_expression
      field: (identifier) @type)
    (identifier)])

(enum_type
  variants: (initializer_list (identifier) @type))

; Implicit enums, like: .Ok
(selector_expression
  !parent
  field: (identifier) @type)

(compiler_directive) @attribute
(calling_convention) @attribute

(pragma_identifier) @attribute

((identifier) @constant
  (#match? @constant "^[A-Z_]+$"))

[
 "."
 ","
 ";"
 ":"
] @punctuation.delimiter

[
 "["
 "]"
 "("
 ")"
 "{"
 "}"
] @punctuation.bracket
