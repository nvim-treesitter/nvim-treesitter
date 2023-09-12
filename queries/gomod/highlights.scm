[
  "require"
  "replace"
  "go"
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
