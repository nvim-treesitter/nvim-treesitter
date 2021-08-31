; Variables

(variable_name) @variable

; Types

[
 (primitive_type)
 (cast_type)
 ] @type.builtin
(named_type (name)) @type
(named_type (qualified_name)) @type

; Functions

(array_creation_expression "array" @function.builtin)
(list_literal "list" @function.builtin)

(method_declaration
  name: (name) @method)

(function_call_expression
  function: (qualified_name (name)) @function)

(function_call_expression
  (name) @function)

(scoped_call_expression
  name: (name) @function)

(member_call_expression
  name: (name) @method)

(function_definition
  name: (name) @function)

(nullsafe_member_call_expression
    name: (name) @method)

; Member

(property_element
  (variable_name) @property)

(member_access_expression
  name: (variable_name (name)) @property)

(member_access_expression
  name: (name) @property)

; Variables

(relative_scope) @variable.builtin

((name) @constant
 (#vim-match? @constant "^_?[A-Z][A-Z\d_]+$"))

((name) @constructor
 (#match? @constructor "^[A-Z]"))

((name) @variable.builtin
 (#eq? @variable.builtin "this"))

(variable_name) @variable

; Basic tokens

[
 (string)
 (heredoc)
 ] @string

(boolean) @boolean
(null) @constant.builtin
(integer) @number
(float) @float
(comment) @comment

; Keywords

[
 "as"
] @keyword.operator

[
 "fn"
 "function"
] @keyword.function

[
 "$"
 "abstract"
 "break"
 "class"
 "const"
 "continue"
 "declare"
 "default"
 "echo"
 "enddeclare"
 "extends"
 "final"
 "global"
 "implements"
 "insteadof"
 "instanceof"
 "interface"
 "namespace"
 "new"
 "private"
 "protected"
 "public"
 "static"
 "trait"
 ] @keyword

"return" @keyword.return

[
 "case"
 "else"
 "elseif"
 "endif"
 "endswitch"
 "if"
 "switch"
 "match"
 ] @conditional

[
 "do"
 "endfor"
 "endforeach"
 "endwhile"
 "for"
 "foreach"
 "while"
 ] @repeat

[
 "catch"
 "finally"
 "throw"
 "try"
 ] @exception

[
 "include_once"
 "include"
 "require_once"
 "require"
 "use"
 ] @include

[
 ","
 ";"
 "."
 ] @punctuation.delimiter

[
 (php_tag)
 "?>"
 "("
 ")"
 "["
 "]"
 "{"
 "}"
 ] @punctuation.bracket

[
  "="

  "-"
  "*"
  "/"
  "+"
  "%"

  "~"
  "|"
  "&"
  "<<"
  ">>"

  "->"
  "?->"

  "=>"

  "<"
  "<="
  ">="
  ">"
  "=="
  "!="
  "==="
  "!=="

  "!"
  "&&"
  "||"

  "-="
  "+="
  "*="
  "/="
  "%="
  "|="
  "&="
  "--"
  "++"
] @operator

(ERROR) @error
