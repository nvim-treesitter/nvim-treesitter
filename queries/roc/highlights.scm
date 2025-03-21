;---Most generic types---
(module) @module

(identifier) @variable

(concrete_type) @type

;---annotations----
(annotation_type_def
  (annotation_pre_colon
    (identifier) @type))

(annotation_type_def
  (annotation_pre_colon
    (identifier) @function)
  (function_type))

;----decleration types----
(value_declaration
  (decl_left
    (identifier_pattern
      (identifier) @variable.parameter)))

;---records----
(field_name) @variable.member

(record_field_pattern
  (_
    (identifier) @variable))

;matches the second identifier and all subsequent ones
(field_access_expr
  (identifier) @variable.member)

;highlight module members as records instead of free variables
; avoids highlighting them as out-of-scope vars
(variable_expr
  (module)
  (identifier) @variable.member)

;----comments----
(line_comment) @comment @spell

(doc_comment) @comment.documentation @spell

;-----Punctuation----
[
  "?"
  (arrow)
  (fat_arrow)
  "|"
  ","
  ":"
] @punctuation.delimiter

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

[
  "|"
  "&"
  "<-"
  ".."
  (operator)
] @operator

(wildcard_pattern) @character.special

[
  "if"
  "then"
  "else"
] @keyword.conditional

[
  (implements)
  (when)
  (is)
  (as)
  "as"
  (to)
] @keyword

;----headers-----
[
  "app"
  "expect"
  "module"
  "package"
] @keyword

"import" @keyword.import

(value_declaration
  (decl_left
    (identifier_pattern
      (identifier) @function))
  (expr_body
    (anon_fun_expr)))

;----tags----
(tags_type
  (tag_type) @constructor)

[
  (tag)
  (opaque_tag)
] @constructor

;-----builtins----
(variable_expr
  (module) @module
  (identifier) @boolean
  (#any-of? @boolean "true" "false")
  (#eq? @module "Bool"))

"dbg" @keyword.debug

;----function invocations ----
(function_call_pnc_expr
  caller: (variable_expr
    (identifier) @function.call))

(function_call_pnc_expr
  caller: (field_access_expr
    (identifier) @function.call .))

(bin_op_expr
  (operator
    "|>") @operator
  (variable_expr
    (identifier) @function))

;----function arguments----
(argument_patterns
  (identifier_pattern
    (identifier) @variable.parameter))

(argument_patterns
  (_
    (identifier_pattern
      (identifier) @variable.parameter)))

(argument_patterns
  (_
    (_
      (identifier_pattern
        (identifier) @variable.parameter))))

;-----consts-----
[
  (int)
  (uint)
  (iint)
  (xint)
  (natural)
] @number

[
  (decimal)
  (float)
] @number.float

[
  (string)
  (multiline_string)
] @string

(char) @character
