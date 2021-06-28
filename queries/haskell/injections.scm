;; -----------------------------------------------------------------------------
;; General language injection

(quasiquote
 ((quoter) @language)
 ((quasiquote_body) @content)
)


;; -----------------------------------------------------------------------------
;; shakespeare library
;; NOTE: doesn't support templating

; CoffeeScript: Text.Coffee
(quasiquote
 (quoter) @_name
 (#eq? @_name "coffee")
 ((quasiquote_body) @content)
 (#set! language "coffeescript")
)

; CSS: Text.Cassius, Text.Lucius
(quasiquote
 (quoter) @_name
 (#any-of? @_name "cassius" "lucius")
 ((quasiquote_body) @content)
 (#set! language "css")
)

; HTML: Text.Hamlet
(quasiquote
 (quoter) @_name
 (#any-of? @_name "shamlet" "xshamlet" "hamlet" "xhamlet" "ihamlet")
 ((quasiquote_body) @content)
 (#set! language "html")
)

; JS: Text.Julius
(quasiquote
 (quoter) @_name
 (#any-of? @_name "js" "julius")
 ((quasiquote_body) @content)
 (#set! language "javascript")
)

; TS: Text.TypeScript
(quasiquote
 (quoter) @_name
 (#any-of? @_name "tsc" "tscJSX")
 ((quasiquote_body) @content)
 (#set! language "typescript")
)


;; -----------------------------------------------------------------------------
;; HSX

(quasiquote
 (quoter) @_name
 (#eq? @_name "hsx")
 ((quasiquote_body) @content)
 (#set! language "html")
)
