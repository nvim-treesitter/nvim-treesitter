(ns test {:clj-kondo/ignore true})
; <- punctuation.bracket
; ^ include
;    ^ namespace

 ; asdf
;^^^^^^ comment

 #_ abc
;^^^^^^ comment

 :abc
;^^^^ symbol

 "abc"
;^^^^^ string

 123
;^^^ number

 \c
;^^ character

 true false
;^^^^ ^^^^^ boolean

 nil
;^^^ constant.builtin

 #"asdf"
;^ punctuation.special
;^^^^^^ string.regex

 'abc
;^ string.escape
; ^^^ symbol

 `abc
;^ string.escape
; ^^^ symbol

 ~ ~@ #
;^ ^^ ^punctuation.special

 ()
;^^ punctuation.bracket

 []
;^^ punctuation.bracket

 #{}
;^ punctuation.special
; ^^ punctuation.bracket

 abc
;^^^ variable

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

(.-field)
;^^^^^^^ field

(.method)
;^^^^^^^ method

(Abc/method)
;^^^^^^^^^^ method

 Abc
;^^^ type

 abc.
;^^^^ type

 ^abc
;^ punctuation.special
