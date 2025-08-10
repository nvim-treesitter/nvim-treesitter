(comment) @comment
(integer) @number
(float) @float
(element) @string
(simple_line) @variable.parameter @markup.strong
(input_title) @keyword
(input_key) @property 
(quoted_string) @string 
(geom_line_types) @type
"xyz" @type
"int" @type
"gzmt" @type
"end" @keyword
"*" @keyword
(string) @number 

;; Variables (FIRST - higher priority than general rules) - using @function for prominence
(variable_ref (variable_name) @operator)  ; {r} in geometry blocks
(variable_ref "{" @punctuation.bracket)
(variable_ref "}" @punctuation.bracket)
(variable_def (variable_name) @operator)  ; r in variable definitions
(variable_range (float) @float)
(variable_array (float) @float)

;; Variable definitions in %paras blocks (when parsed as regular kv_pair)
(input_block (input_title (word) @_paras) (input_body (kv_pair (input_key (word) @operator))) (#eq? @_paras "paras"))
;; Variable definitions in pardef subblocks  
(subblock (word) @_pardef (input_body (kv_pair (input_key (word) @operator))) (#eq? @_pardef "pardef"))

";" @punctuation.delimiter

;; Brace blocks
(brace_block "{" @property)
(brace_block "}" @property)
(brace_value (float) @float)
(brace_value (integer) @number)
(constraint_content) @string
"," @punctuation.delimiter

;; General word values (LAST - lower priority)
(value_atom (word) @number)  ; Words used as values get same color as other values

;; Internal coordinate highlighting
(int_line connect1: (integer) @operator)
(int_line connect2: (integer) @operator)  
(int_line connect3: (integer) @operator)
(int_line (coord_value (float) @float))
(int_line (coord_value (variable_ref) @operator))

;; Zmatrix coordinate highlighting - alternating pattern like internal coords
(zmat_line2 zmat_atom1: (integer) @operator)
(zmat_line2 (coord_value (float) @float))
(zmat_line2 (coord_value (variable_ref) @operator))

(zmat_line3 zmat_atom1: (integer) @operator)
(zmat_line3 zmat_atom2: (integer) @operator)
(zmat_line3 (coord_value (float) @float))
(zmat_line3 (coord_value (variable_ref) @operator))

(zmat_line4 zmat_atom1: (integer) @operator)
(zmat_line4 zmat_atom2: (integer) @operator)
(zmat_line4 zmat_atom3: (integer) @operator)
(zmat_line4 (coord_value (float) @float))
(zmat_line4 (coord_value (variable_ref) @operator))

;; Subblocks
(subblock name: (word) @character)
(subblock "end" @character)

;; Compound script highlighting - use node types instead of regexes
(compound_script) @keyword  
(compound_variable_declaration) @keyword
(compound_step_block) @keyword
(compound_end) @keyword
(compound_variable_declaration (variable_name) @function)
(compound_variable_reference (variable_name) @function)
(compound_variable_reference "&{" @punctuation.bracket)
(compound_variable_reference "}" @punctuation.bracket)
(compound_boolean) @boolean
(compound_assignment (variable_name) @function)
(coord_value (compound_variable_reference) @function)

;; Control flow structures
(compound_for_loop) @keyword
(compound_if_block) @keyword

;; For loop keywords and components
(compound_for_loop (variable_name) @function)

;; If/else condition components
(compound_condition) @conditional
(compound_comparison) @operator

;; Array access
(compound_array_access (variable_name) @function)
(compound_array_access "[" @punctuation.bracket)
(compound_array_access "]" @punctuation.bracket)

;; Function calls
(compound_function_call (variable_name) @function.call)
(compound_function_call "(" @punctuation.bracket)
(compound_function_call ")" @punctuation.bracket)

;; Array assignments
(compound_array_assignment (compound_array_access (variable_name) @function))

;; Variables in expressions - general pattern to catch all variable usage
(compound_primary_expr (variable_name) @function)

;; Operators in expressions
(compound_multiplicative_expr "*" @operator)
(compound_multiplicative_expr "/" @operator)
(compound_additive_expr "+" @operator)
(compound_additive_expr "-" @operator)

;; Assignment operators
(compound_assignment "=" @operator)
(compound_array_assignment "=" @operator)

;; Parentheses in expressions and conditions
(compound_primary_expr "(" @punctuation.bracket)
(compound_primary_expr ")" @punctuation.bracket)
(compound_if_block "(" @punctuation.bracket)
(compound_if_block ")" @punctuation.bracket)

;; Semicolons
(compound_assignment ";" @punctuation.delimiter)
(compound_array_assignment ";" @punctuation.delimiter)
(compound_variable_declaration ";" @punctuation.delimiter)
(compound_function_call ";" @punctuation.delimiter)

