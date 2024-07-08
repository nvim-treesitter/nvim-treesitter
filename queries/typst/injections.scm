((comment) @injection.content
  (#set! injection.language "comment"))

(raw_blck
  lang: (ident) @_lang
  (blob) @injection.content
  (#set-lang-from-info-string! @_lang))
