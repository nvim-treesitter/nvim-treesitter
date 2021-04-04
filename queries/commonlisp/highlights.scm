(dis_expr) @comment

(defun_keyword) @function.macro
(defun_header
  function_name: (_) @function)
(defun_header
  lambda_list: (list_lit (sym_lit) @parameter))
(defun_header
  keyword: (defun_keyword "defmethod")
  lambda_list: (list_lit (list_lit . (sym_lit) . (sym_lit) @type)))
(defun_header
  lambda_list: (list_lit (list_lit . (sym_lit) @parameter . (_))))

[
  (accumulation_verb)
  "for"
  "and"
  "finally"
  "thereis"
  "always"
  "when"
  "if"
  "unless"
  "do"
  "loop"
  "below"
  "in"
  "from"
  "across"
  "being"
  "into"
  "with"
  "as"
  "while"
] @function.macro
"=" @operator

(include_reader_macro) @type
"#C" @number

(kwd_lit) @type

(str_lit) @string

(num_lit) @number

((sym_lit)  @boolean (#eq? @boolean "t"))

(nil_lit) @constant.builtin

(comment) @comment

;; metadata experiment
(meta_lit
 marker: "^" @punctuation.special)

;; dynamic variables
((sym_lit) @variable.builtin
 (#match? @variable.builtin "^[*].+[*]$"))

;; gensym
((sym_lit) @variable
 (#match? @variable "^.*#$"))

;; interop-ish
(list_lit
 .
 (sym_lit) @method
 (#match? @method "^\\."))

;; other symbols with dots
((sym_lit) @variable
 (#match? @variable "\\."))

;; quote
"'" @string.escape
(quoting_lit) @string.escape

;; syntax quote
"`" @string.escape
"," @string.escape
",@" @string.escape
(syn_quoting_lit) @string.escape
(unquoting_lit) @none
(unquote_splicing_lit) @none


["(" ")"] @punctuation.bracket

(block_comment) @comment

;; defun-like things
(list_lit
 .
 (sym_lit) @function.macro
 .
 (sym_lit) @function
 (#eq? @function.macro "deftest"))

;; Macros
(list_lit
 .
 (sym_lit) @function.macro
 (#match? @function.macro "^(let|progn|prog1|values|error|or|and|defvar|defparameter|loop|in-package|defpackage|[e]?(type)?case|defclass|if|if-let|when-let|when|unless|cond|switch|declaim|optimize)[*]?$"))

;; constant
((sym_lit) @constant
 (#match? @constant "^[+].+[+]$"))

(var_quoting_lit
  marker: "#'" @type
  value: (_) @type)

"#" @type


;;; clojure.core=> (cp/pprint (sort (keep (fn [[s v]] (when-not (:macro (meta v)) s)) (ns-publics *ns*))))
;;; ...and then some manual filtering...
(list_lit
 .
 (sym_lit) @function.builtin
 (#match? @function.builtin "^(mapcar|reduce|remove-if-not|cons|car|last|nth|equal[p]?|cdr|first|rest|decf|incf|format)$"))

(list_lit
 .
 (sym_lit) @operator
 (#match? @operator "^([+*-+=<>]|<=|>=|/=)$"))


((sym_lit) @type
(#match? @type "^[&]"))

[(array_dimension) "#0A"] @number
