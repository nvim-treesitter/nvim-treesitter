[
  (annotation_targets)
  (const_list)
  (enum)
  (interface)
  (implicit_generics)
  (generics)
  (group)
  (method_parameters)
  (named_return_types)
  (struct)
  (struct_shorthand)
  (union)
] @indent.begin

((struct_shorthand (property)) @indent.align
  (#set! indent.open_delimiter "(")
  (#set! indent.close_delimiter ")"))

((const_list (const_value)) @indent.align
  (#set! indent.open_delimiter "(")
  (#set! indent.close_delimiter ")"))

[
  "}"
  ")"
] @indent.end

[ "{" "}" ] @indent.branch

[ "(" ")" ] @indent.branch

[
  (ERROR)
  (comment)
] @indent.auto
