[
  "enum"
  "extern"
  "grammar"
  "match"
  "type"
  "pub"
] @keyword

[
  "match"
  "else"
] @keyword.conditional

[
  "+"
  "*"
  "?"
  ; TODO: inaccessible node
  ; =>
  "=>@L"
  "=>@R"
] @operator

(grammar_type_params
  [
    "<"
    ">"
  ] @punctuation.bracket)

(symbol
  [
    "<"
    ">"
  ] @punctuation.bracket)

(binding_symbol
  [
    "<"
    ">"
  ] @punctuation.bracket)

(binding_symbol
  name: (identifier) @variable.parameter)

(bare_symbol
  (macro
    (macro_id) @type.definition))

(bare_symbol
  (identifier) @type.definition)

(nonterminal_name
  (macro_id) @type.definition)

(nonterminal_name
  (identifier) @type.definition)

(nonterminal
  (type_ref) @type.builtin)

[
  "("
  ")"
  "["
  "]"
] @punctuation.bracket

[
  ";"
  ":"
] @punctuation.delimiter

(lifetime
  "'" @keyword.modifier)

(lifetime
  (identifier) @attribute)

(lifetime
  (identifier) @attribute.builtin
  (#any-of? @attribute.builtin "static" "_"))

(string_literal) @string

(regex_literal) @string

(annotation
  (id) @function.macro)
