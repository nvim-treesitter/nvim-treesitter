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
(module_path) @text.uri

[
(version)
(go_version)
] @string
