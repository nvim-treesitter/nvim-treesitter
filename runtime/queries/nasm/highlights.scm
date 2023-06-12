;; adapted from https://github.com/naclsn/tree-sitter-nasm/blob/main/queries/highlights.scm

(word) @variable
((word) @constant
  (#lua-match? @constant "^[A-Z_][?A-Z_0-9]+$"))
((word) @constant.builtin
  (#lua-match? @constant.builtin "^__%?[A-Z_a-z0-9]+%?__$"))

[
  (line_here_token)
  (section_here_token)
] @variable.builtin

(label (word) @label)
(assembl_directive_symbols (word) @label)
(assembl_directive_sections (word) @label)

(unary_expression
  operator: _ @operator)
(binary_expression
  operator: _ @operator)

"?" @constant.builtin

(conditional_expression
  [ "?" ":" ] @conditional.ternary)

[
  ":"
  ","
] @punctuation.delimiter

[
  "(" ")"
  "[" "]"
  "{" "}"
] @punctuation.bracket

(instruction_prefix) @keyword
(actual_instruction
  instruction: (word) @function.builtin)

(call_syntax_expression
  base: (word) @function.call)

(size_hint) @type
(struc_declaration
  name: (word) @type)
(struc_instance
  name: (word) @type)

(effective_address
  hint: _ @type)
(effective_address
  segment: _ @constant.builtin)

(register) @variable.builtin

(string_literal) @string

(float_literal) @float

[
  (packed_bcd_literal)
  (number_literal)
] @number

[
  (preproc_alias)
  (preproc_multiline_macro)
  (preproc_multiline_unmacro)
  (preproc_rotate)
  (preproc_pathsearch)
  (preproc_depend)
  (preproc_use)
  (preproc_push)
  (preproc_pop)
  (preproc_repl)
  (preproc_arg)
  (preproc_stacksize)
  (preproc_local)
  (preproc_reporting)
  (preproc_pragma)
  (preproc_line)
  (preproc_clear)
] @preproc

(preproc_include) @include

(preproc_rep_loop) @repeat

(preproc_if) @conditional

[
  (preproc_def)
  (preproc_undef)
] @define

(preproc_function_def) @keyword.function

[
  (preproc_expression)
  (preproc_arg)
] @constant.macro

(preproc_multiline_macro
  name: (word) @function)

[
  (pseudo_instruction_dx)
  (pseudo_instruction_resx)
  (pseudo_instruction_incbin_command)
  (pseudo_instruction_equ_command)
  (pseudo_instruction_times_prefix)
  (pseudo_instruction_alignx_macro)
] @function

[
  (assembl_directive_target)
  (assembl_directive_defaults)
  (assembl_directive_sections)
  (assembl_directive_absolute)
  (assembl_directive_symbols)
  (assembl_directive_common)
  (assembl_directive_symbolfixes)
  (assembl_directive_cpu)
  (assembl_directive_floathandling)
  (assembl_directive_org)
  (assembl_directive_sectalign)
  (assembl_directive_primitive_target)
  (assembl_directive_primitive_defaults)
  (assembl_directive_primitive_sections)
  (assembl_directive_primitive_absolute)
  (assembl_directive_primitive_symbols)
  (assembl_directive_primitive_common)
  (assembl_directive_primitive_symbolfixes)
  (assembl_directive_primitive_cpu)
  (assembl_directive_primitive_floathandling)
  (assembl_directive_primitive_org)
  (assembl_directive_primitive_sectalign)
  (assembl_directive_primitive_warning)
  (assembl_directive_primitive_map)
] @keyword

(comment) @comment @spell
