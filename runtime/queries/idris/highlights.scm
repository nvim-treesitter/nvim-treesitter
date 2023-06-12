; ------------------------------------------------------------------------------
; Literals and comments
[
  (integer)
  (quantity)
] @number

(literal
  (number)) @number.float

(char) @character

[
  (string)
  (pat_string)
  (triple_quote_string)
] @string

(comment) @comment @spell

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^|||"))

(unit) @constant

; more general captures are moved to the top
; before overwritten later by more specific captures
[
  (loname)
  (caname)
] @variable

; ------------------------------------------------------------------------------
; Punctuation
[
  "("
  ")"
  "{"
  "@{"
  "}"
  "["
  "[<"
  "]"
] @punctuation.bracket

[
  (comma)
  (colon)
  (pat_op)
  (tuple_operator)
] @punctuation.delimiter

(pat_name
  (loname) @variable.parameter)

; ------------------------------------------------------------------------------
; Types
(signature
  (loname) @type)

; ------------------------------------------------------------------------------
; Keywords, operators, imports
[
  "if"
  "then"
  "else"
  "case"
  "of"
] @keyword.conditional

[
  "import"
  "module"
  "namespace"
  "parameters"
] @keyword.import

[
  (operator)
  (equal)
  (wildcard)
  "."
  "|"
  "=>"
  "⇒"
  "<="
  "⇐"
  "->"
  "→"
  "<-"
  "←"
  "\\"
  "`"
] @operator

(qualified_loname
  (caname) @module)

(qualified_caname
  (caname) @constructor)

(qualified_operator
  (caname) @module)

(import
  (caname) @module)

(module
  (caname) @module)

[
  "let"
  "in"
] @keyword

[
  (where)
  "rewrite"
  "interface"
  "implementation"
  "using"
  "record"
  "as"
  "do"
  (forall)
  (fixity)
  (impossible)
  (with)
  (proof)
] @keyword.operator

[
  (visibility)
  (totality)
] @keyword.modifier

"data" @keyword.type

[
  "="
  "$="
  ":="
] @operator

(hole) @label

[
  (pragma_language)
  (pragma_default)
  (pragma_builtin)
  (pragma_name)
  (pragma_ambiguity_depth)
  (pragma_auto_implicit_depth)
  (pragma_logging)
  (pragma_prefix_record_projections)
  (pragma_transform)
  (pragma_unbound_implicits)
  (pragma_auto_lazy)
  (pragma_search_timeout)
  (pragma_nf_metavar_threshold)
  (pragma_cg)
  (pragma_allow_overloads)
  (pragma_deprecate)
  (pragma_inline)
  (pragma_noinline)
  (pragma_tcinline)
  (pragma_hide)
  (pragma_unhide)
  (pragma_unsafe)
  (pragma_spec)
  (pragma_foreign)
  (pragma_foreign_impl)
  (pragma_export)
  (pragma_nomangle)
  (pragma_hint)
  (pragma_defaulthint)
  (pragma_globalhint)
  (pragma_extern)
  (pragma_macro)
  (pragma_start)
  (pragma_rewrite)
  (pragma_pair)
  (pragma_integerLit)
  (pragma_stringLit)
  (pragma_charLit)
  (pragma_doubleLit)
  (pragma_TTImpLit)
  (pragma_declsLit)
  (pragma_nameLit)
  (pragma_runElab)
  (pragma_search)
  (pragma_World)
  (pragma_MkWorld)
  (pragma_syntactic)
] @label

; ------------------------------------------------------------------------------
; Functions and variables
(exp_name
  (loname) @function.call)

(constructor
  "constructor" @keyword.function
  .
  (caname) @constructor)

(exp_record_access
  field: (_) @variable.member)

(signature
  name: (loname) @function)

(function
  (lhs
    (funvar
      subject: [
        (loname)
        (caname)
      ] @function)))

(data
  name: (data_name) @type)

(interface_head
  name: (interface_name) @type)

(implementation_head
  (interface_name) @type)
