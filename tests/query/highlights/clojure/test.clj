(ns test {:clj-kondo/ignore true})
; <- @punctuation.bracket
; ^ @keyword.import
;    ^ @module

 ; asdf
;^^^^^^ @comment

 #_ abc
;^^^^^^ @comment

(func obj)
;^^^^ @function.call
;     ^^^ @variable

 #(+ % %1 %&)
;^ @punctuation.special
;  ^ @function.call
;    ^ ^^ ^^ @variable.builtin

 &
;^ @variable.parameter

 ->abc
;^^^^^ @constructor

 ->>abc
;^^^^^^ @variable

 *1 *2 *3 *e
;^^ ^^ ^^ ^^ @variable.builtin

(.method)
;^^^^^^^ @function.method

(.-field)
;^^^^^^^ @variable.member

 Abc/method
;^^^^^^^^^^ @variable.member

(Abc/method)
;^^^^^^^^^^ @function.method

 Abc
;^^^ @type

 abc.
;^^^^ @type

 ^abc
;^ @punctuation.special
