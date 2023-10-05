;; ----------------------------------------------------------------------------
;; Parameters and variables

;; NOTE: These are at the top, so that they have low priority,
;; and don't override destructured parameters 

(variable) @variable
(pat_wildcard) @variable

(function
  patterns: (patterns (_) @parameter))

(exp_lambda (_)+ @parameter "->")

(function 
  infix: (infix
    lhs: (_) @parameter))
(function 
  infix: (infix
    rhs: (_) @parameter))

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
((qualified_module (module) @constructor)
 . (module))
(qualified_type (module) @namespace)
(qualified_variable (module) @namespace)
(import (module) @namespace)
(import (module) @constructor . (module))

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

(signature name: (variable) @function)
((signature name: (variable) @variable)
 (function 
  name: (variable) @_name
  rhs: [
   (exp_literal)
   (exp_apply 
     (exp_name 
       [(constructor)
        (variable)
       ]))
   (quasiquote)
   ((exp_name) . (operator))
  ])
 (#eq? @variable @_name))

((signature name: (variable) @variable)
 (function 
  name: (variable) @_name
  rhs: (exp_infix 
    [
     (exp_literal)
     (exp_apply 
       (exp_name 
         [(constructor)
          (variable)
         ]))
     (quasiquote)
     ((exp_name) . (operator))
    ]))
 (#eq? @variable @_name))

((signature name: (variable) @function)
 (function 
  name: (variable) @_name
  patterns: (patterns))
 (#eq? @function @_name))

(signature 
  name: (variable) @function
  type: (fun))
((signature 
   name: (variable) @_name
   type: (fun))
 (function
   name: (variable) @function)
 (#eq? @function @_name))

(function name: (variable) @function)
(function 
  name: (variable) @variable
  rhs: [
   (exp_literal)
   (exp_apply 
     (exp_name 
       [(constructor)
        (variable)
       ]))
   (quasiquote)
   ((exp_name) . (operator))
  ])
(function 
  name: (variable) @variable
  rhs: (exp_infix [
   (exp_literal)
   (exp_apply 
     (exp_name 
       [(constructor)
        (variable)
       ]))
   (quasiquote)
   ((exp_name) . (operator))
  ]))

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

; consider infix functions as operators
(exp_infix [
  (variable) @operator
  (qualified_variable (variable) @operator)
])
; partially applied infix functions (sections) also get highlighted as operators
(exp_section_right [
  ((variable) @operator)
  (qualified_variable (variable) @operator)
  ]) 
(exp_section_left [
  ((variable) @operator)
  (qualified_variable (variable) @operator)
  ])

; function calls with an infix operator
; e.g. func <$> a <*> b
(exp_infix 
  (exp_name 
    [
      ((variable) @function.call)
      (qualified_variable (
        (module) @namespace
        (variable) @function.call))
    ])
  . (operator))
; infix operators applied to variables
((exp_name (variable) @variable) . (operator))
((operator) . (exp_name (variable) @variable))
; function calls with infix operators
((exp_name (variable) @function.call) . (operator) @_op
 (#any-of? @_op "$" "<$>" ">>=" "=<<"))
; right hand side of infix operator
((exp_infix 
   [(operator)(variable)] ; infix or `func`
  . (exp_name [
      ((variable) @function.call)
      (qualified_variable (variable) @function.call)
    ])) . (operator) @_op
 (#any-of? @_op "$" "<$>" "=<<"))
; function composition, arrows, monadic composition (rhs)
((exp_name [
  ((variable) @function)
  (qualified_variable (variable) @function)
 ]) . (operator) @_op
 (#any-of? @_op "." ">>>" "***" ">=>" "<=<"))
; right hand side of infix operator
((exp_infix 
   [(operator)(variable)] ; infix or `func`
  . (exp_name [
      ((variable) @function)
      (qualified_variable (variable) @function)
    ])) . (operator) @_op
 (#any-of? @_op "." ">>>" "***" ">=>" "<=<"))
; function composition, arrows, monadic composition (rhs)
((operator) @_op . (exp_name [
  ((variable) @function)
  (qualified_variable (variable) @function)
 ])
 (#any-of? @_op "." ">>>" "***" ">=>" "<=<" ))
        
(exp_apply (exp_name 
  [
    ((variable) @function.call)
    (qualified_variable (variable) @function.call)
  ]))
(exp_apply [
    (exp_name [
      (variable)
      (qualified_variable (variable))
      (constructor)
      (qualified_constructor (constructor))
    ])
    (exp_type_application)
    (exp_parens)
    (exp_record)
  ]
  . (exp_name [
    ((variable) @variable)
    (qualified_variable (variable) @variable)
  ]))

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
;; namespaced quasi-quoter
(quasiquote
  (_
    (module) @namespace
    . (variable) @function.call
  ))

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
   "onException"
   "expectationFailure"))

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
;; Fields
(field (variable) @field)
(pat_field (variable) @field)
(exp_projection field: (variable) @field)
(import_item (type) . (import_con_names (variable) @field))


;; ----------------------------------------------------------------------------
;; Spell checking

(comment) @spell
