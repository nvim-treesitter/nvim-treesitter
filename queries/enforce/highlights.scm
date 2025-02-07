(comment_line) @comment @spell
(comment_block) @comment.block @spell

(doc_line) @comment.documentation @spell
(doc_block) @comment.documentation.block @spell

(literal_bool) @boolean
(literal_int) @number
(literal_float) @number.float
(literal_string) @string
(escape_sequence) @string.escape


; vectors
; TODO: what about arrays of vectors?
(decl_variable
  (type_vector)
  (literal_string) @vector
  )

(formal_parameter
  type: (type_vector)
  default: (literal_string) @vector
  )

(identifier) @variable

((identifier) @constant (#lua-match? @constant "^[A-Z_][A-Z%d_]+$"))

; Preprocessor directives
[
 (include)
 (define)
 (ifdef)
 (ifndef)
 (else)
 (endif)
 ] @keyword.directive

(preproc_const) @constant.macro

; Constant fields
(decl_field
  ((field_modifier) @_modifier (#eq? @_modifier "const"))
  type: (_)
  name: (identifier) @constant
  )

(enum_member name: (identifier) @constant)

[
 "+" "-" "*" "/" "%" "^"
 "++" "--"
 "=" "+=" "-=" "*=" "/=" "&=" "^=" "|=" "<<=" ">>="
 "<" "<=" ">=" ">"
 "==" "!="
 "!" "&&" "||" ">>" "<<" "&" "|" "^" "~"
 ] @operator

[
 "(" ")"
 "[" "]"
 "{" "}"
 ] @punctuation.bracket

; TODO: <> in decl_class
(types [ "<" ">" ] @punctuation.bracket)

[
 "," "." ":" ";"
 ] @punctuation.delimiter

(literal_string ["\"" "\""] @punctuation.delimiter)

[
 "continue" "break"
 "switch" "case"
 "typedef"
 "delete"
 "default"
 "extends"
 "new" ; TODO: is it operator?
 "auto" ; TODO: is it type?
 ] @keyword

; ["thread"] @keyword.coroutine

["return"] @keyword.return
["if" "else"] @keyword.conditional
["while" "for" "foreach"] @keyword.repeat
["enum" "class"] @keyword.type
[
 (variable_modifier)
 (method_modifier)
 (class_modifier)
 (field_modifier)
 (formal_parameter_modifier)
 ] @keyword.modifier

["ref"] @type
(decl_class typename: (identifier) @type)
(decl_enum typename: (identifier) @type)
(type_identifier (identifier) @type)

(type_primitive) @type.builtin

[
 (super)
 (this)
 (literal_null)
 ] @variable.builtin

(decl_method
  name: (identifier) @function.method
 )

(invokation
  invoked: (identifier) @function.method.call
  )

; Constructor and deconstructor (function with same name of the class)
(decl_class
  typename: (identifier) @foo
  body: (class_body
    (decl_method
	    name: (identifier) @constructor
	    (#eq? @constructor @foo)
      )
    )
  )

; TODO: mark invalid deconstructor as error?
(decl_class
  typename: (identifier) @foo
  body: (class_body
    (decl_method
      "~"
	    name: (identifier) @constructor.deconstructor
	    (#eq? @constructor.deconstructor @foo)
      )
    )
  )

; Constant fields
; (decl_field
;   ((field_modifier) @_modifier (#eq? @_modifier "const"))
;   (_)
;   (identifier) @constant
;   )

; TODO: mark assignment to const as error?

; Constant parameters and local variables referencing to it
; (decl_method
;   (formal_parameters
;   	(formal_parameter
;   	  ((formal_parameter_modifier) @_modifier (#eq? @_modifier "const"))
;   	  name: (identifier) @_constantParam @constant
;   	  )
;   	)
;   body: (block
;   	(_
;   	  ((identifier) @constant (#eq? @constant @_constantParam))
;   	  )
;   	)
;   )

; Dead code
(block
  (_)*
  (return)
  (_)* @deadcode (#set! "priority" 110)
  )

(ERROR) @error

; TODO: string and print format injection
