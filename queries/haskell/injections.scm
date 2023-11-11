; -----------------------------------------------------------------------------
; General language injection
(quasiquote
  (quoter) @injection.language
  (quasiquote_body) @injection.content)

((comment) @injection.content
  (#set! injection.language "comment"))

; -----------------------------------------------------------------------------
; shakespeare library
; NOTE: doesn't support templating
; TODO: add once CoffeeScript parser is added
; ; CoffeeScript: Text.Coffee
; (quasiquote
;  (quoter) @_name
;  (#eq? @_name "coffee")
;  ((quasiquote_body) @injection.content
;   (#set! injection.language "coffeescript")))
; CSS: Text.Cassius, Text.Lucius
(quasiquote
  (quoter) @_name
  (#any-of? @_name "cassius" "lucius")
  (quasiquote_body) @injection.content
  (#set! injection.language "css"))

; HTML: Text.Hamlet
(quasiquote
  (quoter) @_name
  (#any-of? @_name "shamlet" "xshamlet" "hamlet" "xhamlet" "ihamlet")
  (quasiquote_body) @injection.content
  (#set! injection.language "html"))

; JS: Text.Julius
(quasiquote
  (quoter) @_name
  (#any-of? @_name "js" "julius")
  (quasiquote_body) @injection.content
  (#set! injection.language "javascript"))

; TS: Text.TypeScript
(quasiquote
  (quoter) @_name
  (#any-of? @_name "tsc" "tscJSX")
  (quasiquote_body) @injection.content
  (#set! injection.language "typescript"))

; -----------------------------------------------------------------------------
; HSX
(quasiquote
  (quoter) @_name
  (#eq? @_name "hsx")
  (quasiquote_body) @injection.content
  (#set! injection.language "html"))

; -----------------------------------------------------------------------------
; Inline JSON from aeson
(quasiquote
  (quoter) @_name
  (#eq? @_name "aesonQQ")
  (quasiquote_body) @injection.content
  (#set! injection.language "json"))

; -----------------------------------------------------------------------------
; SQL
; postgresql-simple
(quasiquote
  (quoter) @injection.language
  (#eq? @injection.language "sql")
  (quasiquote_body) @injection.content)

(quasiquote
  (quoter) @_name
  (#any-of? @_name "persistUpperCase" "persistLowerCase" "persistWith")
  (quasiquote_body) @injection.content
  (#set! injection.language "haskell_persistent"))
