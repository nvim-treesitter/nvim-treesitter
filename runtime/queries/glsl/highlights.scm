; inherits: c

[
  "in"
  "out"
  "inout"
  "uniform"
  "shared"
  "layout"
  "attribute"
  "varying"
  "buffer"
  "coherent"
  "readonly"
  "writeonly"
  "precision"
  "highp"
  "mediump"
  "lowp"
  "centroid"
  "sample"
  "patch"
  "smooth"
  "flat"
  "noperspective"
  "invariant"
  "precise"
] @keyword.modifier

"subroutine" @keyword.function

(extension_storage_class) @keyword.modifier

((identifier) @variable.builtin
  (#lua-match? @variable.builtin "^gl_"))
