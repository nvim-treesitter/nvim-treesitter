[
 (comment_line)
 (comment_block)
 ] @comment @spell

[
 (doc_line)
 (doc_block)
 ] @comment.documentation @spell

(literal_bool) @boolean
(literal_int) @number
(literal_float) @number.float
(literal_string) @string
(escape_sequence) @string.escape

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
  typename: (identifier) @_classname
  body: (class_body
    (decl_method
      name: (identifier) @constructor
      (#eq? @constructor @_classname)
      )
    )
  )
