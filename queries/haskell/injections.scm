;; -----------------------------------------------------------------------------
;; General language injection

(quasiquote
 ((quoter) @language)
 ((quasiquote_body) @content)
)


;; -----------------------------------------------------------------------------
;; shakespeare library
;; NOTE: excludes CoffeeScript (Text.Coffee) and doesn't support templating

; CSS: Text.Cassius, Text.Lucius
(quasiquote
 (quoter) @_name
 (#any-of? @_name "cassius" "lucius")
 ((quasiquote_body) @css)
)

; HTML: Text.Hamlet
(quasiquote
 (quoter) @_name
 (#any-of? @_name "shamlet" "xshamlet" "hamlet" "xhamlet" "ihamlet")
 ((quasiquote_body) @html)
)

; JS: Text.Julius
(quasiquote
 (quoter) @_name
 (#any-of? @_name "js" "julius")
 ((quasiquote_body) @javascript)
)

; TS: Text.TypeScript
(quasiquote
 (quoter) @_name
 (#any-of? @_name "tsc" "tscJSX")
 ((quasiquote_body) @typescript)
)


;; -----------------------------------------------------------------------------
;; HSX

(quasiquote
 (quoter) @_name
 (#eq? @_name "hsx")
 ((quasiquote_body) @html)
)
