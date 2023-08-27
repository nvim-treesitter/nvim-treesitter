(ns test {:clj-kondo/ignore true})
; <- punctuation.bracket
; ^ include
;    ^ namespace

 ; asdf
;^^^^^^ comment

 #_ abc
;^^^^^^ comment

(func obj)
;^^^^ function.call
;     ^^^ variable

 #(+ % %1 %&)
;^ punctuation.special
;  ^ function.call
;    ^ ^^ ^^ variable.builtin

 &
;^ parameter

 ->abc
;^^^^^ constructor

 ->>abc
;^^^^^^ variable

 *1 *2 *3 *e
;^^ ^^ ^^ ^^ variable.builtin

(.method)
;^^^^^^^ method

(.-field)
;^^^^^^^ field

 Abc/method
;^^^^^^^^^^ field

(Abc/method)
;^^^^^^^^^^ method

 Abc
;^^^ type

 abc.
;^^^^ type

 ^abc
;^ punctuation.special
