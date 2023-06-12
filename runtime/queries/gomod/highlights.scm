[
  "require"
  "replace"
  "go"
  "toolchain"
  "exclude"
  "retract"
  "module"
] @keyword

"=>" @operator

(comment) @comment @spell

(module_path) @string.special.url

[
  (version)
  (go_version)
  (toolchain_name)
] @string.special

[
  "("
  ")"
  "["
  "]"
] @punctuation.bracket

"," @punctuation.delimiter
