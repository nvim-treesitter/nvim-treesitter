;; ----------------------------------------------------------------------------
;; Parameters

;; NOTE: These are at the top, so that they have low priority,
;; and don't override destructured parameters 

(function
  patterns: (patterns (pat_name) @parameter))

(exp_lambda
  (pat_name) @parameter)

;; ----------------------------------------------------------------------------
;; Literals and comments

(integer) @number
(exp_negation) @number
(exp_literal (float)) @float
(char) @character
(string) @string

(con_unit) @symbol  ; unit, as in ()

(comment) @comment

; FIXME: The below documentation comment queries are inefficient
; and need to be anchored, using something like
; ((comment) @_first . (comment)+ @comment.documentation)
; once https://github.com/neovim/neovim/pull/24738 has been merged.
;
; ((comment) @comment.documentation 
;   (#lua-match? @comment.documentation "^-- |"))
;
; ((comment) @_first @comment.documentation 
;  (comment) @comment.documentation 
;   (#lua-match? @_first "^-- |"))
;
; ((comment) @comment.documentation 
;   (#lua-match? @comment.documentation "^-- %^"))
;
; ((comment) @_first @comment.documentation 
;  (comment) @comment.documentation 
;   (#lua-match? @_first "^-- %^"))
;
; ((comment) @comment.documentation 
;   (#lua-match? @comment.documentation "^{-"))
;
; ((comment) @_first @comment.documentation 
;  (comment) @comment.documentation 
;   (#lua-match? @_first "^{-"))

;; ----------------------------------------------------------------------------
;; Punctuation

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

[
  (comma)
  ";"
] @punctuation.delimiter


;; ----------------------------------------------------------------------------
;; Keywords, operators, includes

[
  "forall"
  "∀"
] @repeat

(pragma) @preproc

[
  "if"
  "then"
  "else"
  "case"
  "of"
] @conditional

[
  "import"
  "qualified"
  "module"
] @include

[
  (operator)
  (constructor_operator)
  (type_operator)
  (tycon_arrow)
  (qualified_module)  ; grabs the `.` (dot), ex: import System.IO
  (qualified_type)
  (qualified_variable)
  (all_names)
  (wildcard)
  "."
  ".."
  "="
  "|"
  "::"
  "=>"
  "->"
  "<-"
  "\\"
  "`"
  "@"
] @operator


(module) @namespace
(qualified_module (module) @constructor)
(qualified_type (module) @namespace)
(qualified_variable (module) @namespace)
(import (module) @namespace)

[
  (where)
  "let"
  "in"
  "class"
  "instance"
  "pattern"
  "data"
  "newtype"
  "family"
  "type"
  "as"
  "hiding"
  "deriving"
  "via"
  "stock"
  "anyclass"
  "do"
  "mdo"
  "rec"
  "infix"
  "infixl"
  "infixr"
] @keyword


;; ----------------------------------------------------------------------------
;; Functions and variables

(variable) @variable
(pat_wildcard) @variable
(signature name: (variable) @variable)

(function
  name: (variable) @function
  patterns: (patterns))
(function
  name: (variable) @function
  rhs: (exp_lambda))
((signature (variable) @function (fun)) . (function (variable)))
((signature (variable) @_type (fun)) . (function (variable) @function) (#eq? @function @_type))
((signature (variable) @function (context (fun))) . (function (variable)))
((signature (variable) @_type (context (fun))) . (function (variable) @function) (#eq? @function @_type))
((signature (variable) @function (forall (context (fun)))) . (function (variable)))
((signature (variable) @_type (forall (context (fun)))) . (function (variable) @function) (#eq? @function @_type))

(exp_infix (variable) @operator)  ; consider infix functions as operators
(exp_section_right (variable) @operator) ; partially applied infix functions (sections) also get highlighted as operators
(exp_section_left (variable) @operator)

(exp_infix (exp_name) @function.call (#set! "priority" 101))
(exp_apply . (exp_name (variable) @function.call))
(exp_apply . (exp_name (qualified_variable (variable) @function.call)))

;; ----------------------------------------------------------------------------
;; Types

(type) @type
(type_star) @type
(type_variable) @type

(constructor) @constructor

; True or False
((constructor) @boolean (#any-of? @boolean "True" "False"))
; otherwise (= True)
((variable) @boolean
  (#eq? @boolean "otherwise"))

;; ----------------------------------------------------------------------------
;; Quasi-quotes

(quoter) @function.call

(quasiquote 
  (quoter) @_name (#eq? @_name "qq")
  (quasiquote_body) @string)

; Highlighting of quasiquote_body for other languages is handled by injections.scm

;; ----------------------------------------------------------------------------
;; Exceptions/error handling

((variable) @exception
  (#any-of? @exception 
   "error"
   "undefined"
   "try"
   "tryJust"
   "tryAny"
   "catch"
   "catches"
   "catchJust"
   "handle"
   "handleJust"
   "throw"
   "throwIO"
   "throwTo"
   "throwError"
   "ioError"
   "mask"
   "mask_"
   "uninterruptibleMask"
   "uninterruptibleMask_"
   "bracket"
   "bracket_"
   "bracketOnErrorSource"
   "finally"
   "onException"))

;; ----------------------------------------------------------------------------
;; Debugging
((variable) @debug
  (#any-of? @debug 
   "trace"
   "traceId"
   "traceShow"
   "traceShowId"
   "traceWith"
   "traceShowWith"
   "traceStack"
   "traceIO"
   "traceM"
   "traceShowM"
   "traceEvent"
   "traceEventWith"
   "traceEventIO"
   "flushEventLog"
   "traceMarker"
   "traceMarkerIO"))


;; ----------------------------------------------------------------------------
;; Record fields
(record_fields (field (variable) @field))


;; ----------------------------------------------------------------------------
;; Spell checking

(comment) @spell

