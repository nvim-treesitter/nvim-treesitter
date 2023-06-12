[
  (block)
  (object)
  (array)
  (arguments)
] @indent.begin

(block
  "}" @indent.end)

(object
  "}" @indent.end)

(array
  "]" @indent.end)

(arguments
  ")" @indent.end)

[
  ")"
  "]"
  "}"
] @indent.branch
