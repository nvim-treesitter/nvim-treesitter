((latex) @injection.content
  (#set! injection.language "latex")
  (#set! injection.combined))

(rchunk
  (renv_content) @injection.content
  (#set! injection.language "r")
  (#set! injection.combined))

(rinline
  (renv_content) @injection.content
  (#set! injection.language "r"))
