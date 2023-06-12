(comment) @comment @spell

"grammar" @keyword

[
  "type"
  "enum"
] @keyword.type

[
  "pub"
  "extern"
  (mut)
] @keyword.modifier

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
  "="
  "&"
] @operator

(binding_symbol
  name: (identifier) @variable.parameter)

(annotation
  "#" @punctuation.special)

(grammar_parameter
  (identifier) @variable.parameter)

(associated_type
  (identifier) @type)

(parametrized_type
  (path
    (identifier) @type))

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
  "}"
  "{"
  ">"
  "<"
] @punctuation.bracket

[
  ";"
  ":"
  "::"
  ","
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
