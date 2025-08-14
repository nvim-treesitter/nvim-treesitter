(comment) @comment

(integer) @number

(float) @number.float

(element) @character

(simple_line) @variable.builtin

(input_title) @keyword

(input_key) @variable

(quoted_string) @string

(string) @string

(constraint_content) @string

[
  "*"
  "/"
  "+"
  "-"
  "="
] @operator

(geom_block
  "*" @keyword)

(geom_line
  "*" @keyword
  (file) @string.special.path)

[
  (geom_line_types)
  "xyz"
  "int"
  "gzmt"
] @type

; Variables (FIRST - higher priority than general rules) - using @function for prominence
(variable_ref
  (variable_name) @variable) ; {r} in geometry blocks

(variable_def
  (variable_name) @variable) ; r in variable definitions

(variable_range
  (float) @number.float)

(variable_array
  (float) @number.float)

; General word values (LAST - lower priority)
(value_atom
  (word) @number) ; Words used as values get same color as other values

; Internal coordinate highlighting
(int_line
  connect1: (integer) @operator
  connect2: (integer) @operator
  connect3: (integer) @operator)

(int_line
  (coord_value
    (float) @number.float))

(int_line
  (coord_value
    (variable_ref) @operator))

; Zmatrix coordinate highlighting - alternating pattern like internal coords
(zmat_line2
  zmat_atom1: (integer) @operator)

(zmat_line2
  (coord_value
    (float) @number.float))

(zmat_line2
  (coord_value
    (variable_ref) @operator))

(zmat_line3
  zmat_atom1: (integer) @operator
  zmat_atom2: (integer) @operator)

(zmat_line3
  (coord_value
    (float) @number.float))

(zmat_line3
  (coord_value
    (variable_ref) @operator))

(zmat_line4
  zmat_atom1: (integer) @operator
  zmat_atom2: (integer) @operator
  zmat_atom3: (integer) @operator
  (coord_value
    (float) @number.float))

(zmat_line4
  (coord_value
    (variable_ref) @operator))

; Subblocks
(subblock
  name: (word) @module)

(subblock
  "end" @module)

; Compound script highlighting - use node types instead of regexes
[
  (compound_script)
  (compound_variable_declaration)
  (compound_step_block)
  (compound_end)
  (compound_for_loop)
  (compound_if_block)
] @keyword

(compound_variable_declaration
  (variable_name) @variable)

(compound_variable_reference
  (variable_name) @variable)

(compound_boolean) @boolean

(compound_assignment
  (variable_name) @variable)

; If/else condition components
(compound_condition) @keyword.conditional

(compound_comparison) @operator

; Array access
(compound_array_access
  (variable_name) @function)

";" @punctuation.delimiter

"," @punctuation.delimiter

[
  "["
  "]"
  "{"
  "}"
  "&{"
] @punctuation.bracket

(compound_function_call
  "(" @punctuation.bracket)

(compound_function_call
  ")" @punctuation.bracket)

; Parentheses in expressions and conditions
; Function calls
(compound_function_call
  (variable_name) @function.call)

; Array assignments
(compound_array_assignment
  (compound_array_access
    (variable_name) @function))

; Variables in expressions - general pattern to catch all variable usage
(compound_primary_expr
  (variable_name) @function)
