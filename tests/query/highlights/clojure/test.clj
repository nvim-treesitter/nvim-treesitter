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

 #(+ % %1 %& %a)
;^ @punctuation.special
;  ^ @function.call
;    ^ ^^ ^^ @variable.builtin
;            ^^ @variable

 abc#
;^^^^ @variable

 &
;^ @variable.parameter

 ->abc
;^^^^^ @constructor

 ->>abc
;^^^^^^ @variable

 *1 *2 *3 *e
;^^ ^^ ^^ ^^ @variable.builtin

 .method
;^^^^^^^ @function.method

(.method foo)
;^^^^^^^ @function.method

(.-field foo)
;^^^^^^^ @variable.member

 Abc/member
;^^^^^^^^^^ @variable.member

(Abc/method)
;^^^^^^^^^^ @function.method

 Abc
;^^^ @type

 abc.
;^^^^ @type

 ^abc
;^ @punctuation.special

^java.io.File file
; <- @punctuation.special
;^^^^^^^^^^^^ @type
;             ^^^^ @variable

^java.io.File java.io.File.
; <- @punctuation.special
;^^^^^^^^^^^^ @type
;             ^^^^ @variable

^java.io.File file.
; <- @punctuation.special
;^^^^^^^^^^^^ @type
;             ^^^^ @variable

(^java.io.File file)
;^ @punctuation.special
; ^^^^^^^^^^^^ @type
;              ^^^^ @function.call

(^java.io.File .file foo)
;^ @punctuation.special
; ^^^^^^^^^^^^ @type
;              ^^^^ @function.method
;                    ^^^@variable

(^java.io.File .-file foo)
;^ @punctuation.special
; ^^^^^^^^^^^^ @type
;              ^^^^ @variable.member
;                     ^^^@variable

(^java.io.File Abc/method foo)
;^ @punctuation.special
; ^^^^^^^^^^^^ @type
;              ^^^^^^^^^^ @function.method
;                         ^^^ @variable

 (defn foo [arg1] (+ arg1 1))
;^         ^    ^ ^        ^^ @punctuation.bracket
; ^^^^ @keyword.function
;      ^^^ @function
;           ^^^^     ^^^^ @variable
;                  ^ @operator
;                         ^ @number

 clojure.core/dfn
;^^^^^^^^^^^^^^^^ @variable

 clojure.core/defn
;^^^^^^^^^^^^^^^^ @keyword.function

 any-ns/defn
;^^^^^^^^^^^ @keyword.function
