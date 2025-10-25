(comment) @comment @spell

(integer) @number

(float) @number.float

(element) @character

(simple_line) @variable.builtin

(input_title) @keyword

[
 (variable_kw)
 (end_kw)
 ; for loop
 (for_kw)
 (from_kw)
 (to_kw)
 (do_kw)
 (endfor_kw)
 ; if else
 (if_kw)
 (then_kw)
 (else_kw)
 (endif_kw)
 ; compound
 (new_step_kw)
 (step_end_kw)
 (compound_end)
 ] @keyword

(input_key) @variable

(quoted_string) @string

(string) @string

(variable_name) @variable

; TODO: Add constraint choice and contraint flag
(constraint_content) @string

[
  "*"
  "/"
  "+"
  "-"
  "="
] @operator

(geom_block
  "*" @punctuation.special)

(geom_line
  "*" @punctuation.special
  (file) @string.special.path)

[
  (geom_line_types)
  "xyz"
  "int"
  "gzmt"
] @type

; General word values (LAST - lower priority)
(value_atom
  (word) @number) ; Words used as values get same color as other values

; Subblocks
(subblock
  name: (word) @keyword)

; TODO: This needs to be made more precise
; Compound script highlighting - use node types instead of regexes
; [
;   (compound_script)
;   (compound_variable_declaration)
;   (compound_step_block)
;   (compound_end)
;   (compound_for_loop)
;   (compound_if_block)
; ] @keyword

(compound_boolean) @boolean

; If/else condition components
(compound_condition) @keyword.conditional

(compound_comparison) @operator

[
 ";"
 ","
] @punctuation.delimiter

[
  "["
  "]"
  "{"
  "}"
  "&{"
  "("
  ")"
] @punctuation.bracket

; Parentheses in expressions and conditions
; Function calls
(compound_function_call
  (variable_name) @function.call)

