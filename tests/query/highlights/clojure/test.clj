(ns test {:clj-kondo/ignore true})
; <- punctuation.bracket
; ^ include
;    ^ namespace

'abc
; <- string.escape
; ^ symbol

:abc
; <- keyword
; ^ keyword

(func obj)
; ^ function.call
;     ^ variable

(.-field obj)
; ^ field
;        ^ variable

(.method obj)
; ^ method
;        ^ variable
