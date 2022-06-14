; inherits: cpp

[
  "in"
  "out"
  "inout"
  "uniform"
  "shared"
  "groupshared"
  "discard"
  "cbuffer"
  "nointerpolation"
  "row_major"
  "column_major"
] @keyword

(
  (identifier) @variable.builtin
  (#lua-match? @variable.builtin "^SV_")
)

(hlsl_attribute) @attribute
(hlsl_attribute ["[" "]"] @attribute)
