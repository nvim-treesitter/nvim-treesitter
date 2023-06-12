((host_lang) @injection.content
  (#set! injection.parent))

((define
   option: (option_name) @_yy
   value: (dstring) @injection.content)
  (#any-of? @_yy "YYPEEK" "YYSKIP" "YYBACKUP" "YYBACKUPCTX" "YYRESTORE" "YYRESTORECTX" "YYFILL" "YYSHIFT")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.parent))

((comment) @injection.content
  (#set! injection.language "comment"))
