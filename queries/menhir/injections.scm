([
  (comment)
  (line_comment)
  (ocaml_comment)
] @injection.content
  (#set! injection.language "comment"))

((ocaml) @injection.content
  (#set! injection.language "ocaml"))
