[
  "render_mode"
  "shader_type"
  "group_uniforms"
  "global"
  "instance"
  "const"
  "varying"
  "uniform"
] @keyword

"struct" @keyword.type

[
  (precision_qualifier)
  (interpolation_qualifier)
] @keyword.modifier

[
  "in"
  "out"
  "inout"
] @keyword.modifier

[
  "while"
  "for"
] @keyword.repeat

[
  "continue"
  "break"
  "return"
] @keyword.return

[
  "if"
  "else"
  "switch"
  "case"
  "default"
] @keyword.conditional

[
  "#"
  "include"
] @keyword.directive

(string) @string

[
  "="
  "+="
  "-="
  "!"
  "~"
  "+"
  "-"
  "*"
  "/"
  "%"
  "||"
  "&&"
  "|"
  "^"
  "&"
  "=="
  "!="
  ">"
  ">="
  "<="
  "<"
  "<<"
  ">>"
  "++"
  "--"
] @operator

(boolean) @boolean

(integer) @number

(float) @number.float

[
  "."
  ","
  ";"
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

(builtin_type) @type.builtin

(ident_type) @type.definition

[
  (shader_type)
  (render_mode)
  (hint_name)
] @attribute

(builtin_variable) @constant.builtin

(builtin_function) @function.builtin

(group_uniforms_declaration
  group_name: (ident) @property
  subgroup_name: (ident) @property)

(struct_declaration
  name: (ident) @type)

(struct_member
  name: (ident) @property)

(function_declaration
  name: (ident) @function)

(parameter
  name: (ident) @variable.parameter)

(member_expr
  member: (ident) @property)

(call_expr
  function: [
    (ident)
    (builtin_type)
  ] @function)

(call_expr
  function: (builtin_type) @function.call)

(comment) @comment @spell
