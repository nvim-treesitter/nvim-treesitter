; =============================================================================
; HelixQL Syntax Highlighting for Neovim Tree-sitter
; =============================================================================
; NOTE: In tree-sitter queries, later patterns override earlier ones.
; Put general patterns first, then specific overrides after.
; -----------------------------------------------------------------------------
; Comments
; -----------------------------------------------------------------------------
(comment) @comment @spell

; -----------------------------------------------------------------------------
; Literals
; -----------------------------------------------------------------------------
(string_literal) @string

(integer) @number

(float) @number.float

(boolean) @boolean

(none) @constant.builtin

(now) @constant.builtin

; -----------------------------------------------------------------------------
; Generic identifiers
; -----------------------------------------------------------------------------
(identifier) @variable

(identifier_upper) @type

; -----------------------------------------------------------------------------
; Keywords
; -----------------------------------------------------------------------------
[
  "QUERY"
  "RETURN"
  "FOR"
  "IN"
] @keyword

; Node type keywords (wrapped in their own rules)
(index) @keyword

(default) @keyword

(count) @keyword

(ID) @constant.builtin

; Keywords inside node types
(where_step
  "WHERE" @keyword)

(range_step
  "RANGE" @keyword)

(update
  "UPDATE" @keyword)

(drop
  "DROP" @keyword)

(exists
  "EXISTS" @keyword)

; Boolean and logical operators
(and
  "AND" @keyword.operator)

(or
  "OR" @keyword.operator)

(GT
  "GT" @keyword.operator)

(GTE
  "GTE" @keyword.operator)

(LT
  "LT" @keyword.operator)

(LTE
  "LTE" @keyword.operator)

(EQ
  "EQ" @keyword.operator)

(NEQ
  "NEQ" @keyword.operator)

; Creation operation keywords
(AddN
  "AddN" @function.builtin)

(AddE
  "AddE" @function.builtin)

(AddV
  "AddV" @function.builtin)

(BatchAddV
  "BatchAddV" @function.builtin)

(search_vector
  "SearchV" @function.builtin)

; -----------------------------------------------------------------------------
; Schema definition keywords
; -----------------------------------------------------------------------------
[
  "N::"
  "E::"
  "V::"
] @keyword.directive

[
  "From:"
  "To:"
  "Properties"
] @keyword.modifier

; -----------------------------------------------------------------------------
; Graph traversal methods
; -----------------------------------------------------------------------------
(out_e
  "OutE" @function.method)

(in_e
  "InE" @function.method)

(from_n) @function.method

(to_n) @function.method

(out
  "Out" @function.method)

(in_nodes
  "In" @function.method)

(shortest_path
  "ShortestPath" @function.method)

; -----------------------------------------------------------------------------
; Start nodes - highlight N, E, V as keywords
; -----------------------------------------------------------------------------
(start_node
  "N" @keyword)

(start_edge
  "E" @keyword)

(start_vector
  "V" @keyword)

; -----------------------------------------------------------------------------
; Types
; -----------------------------------------------------------------------------
(named_type) @type.builtin

(date_type) @type.builtin

(ID_TYPE) @type.builtin

; Type arguments in angle brackets
(type_args
  (identifier_upper) @type)

; -----------------------------------------------------------------------------
; Specific identifier patterns (override generic rules)
; -----------------------------------------------------------------------------
; Query/function names
(query_def
  name: (identifier) @function)

; Schema definition names
(node_def
  name: (identifier_upper) @type.definition)

(edge_def
  name: (identifier_upper) @type.definition)

(vector_def
  name: (identifier_upper) @type.definition)

; Parameter names in function signatures
(param_def
  name: (identifier) @variable.parameter)

; Field names in schema definitions
(field_def
  name: (identifier) @property)

; Property keys in object creation
(new_field
  key: (identifier) @property)

; Property keys in updates
(update_field
  key: (identifier) @property)

; Property keys in object mapping (left of :)
(mapping_field
  (identifier) @property
  ":")

; Object access field
(object_access
  field: (identifier) @property)

; Variable assignment targets (left of <-)
(get_stmt
  variable: (identifier) @variable)

; For loop iterable
(for_loop
  iterable: (identifier) @variable)

; -----------------------------------------------------------------------------
; Operators
; -----------------------------------------------------------------------------
[
  "<-"
  "=>"
  "::"
  "."
  ".."
  "!"
] @operator

; -----------------------------------------------------------------------------
; Punctuation
; -----------------------------------------------------------------------------
[
  ":"
  ","
] @punctuation.delimiter

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
  "<"
  ">"
] @punctuation.bracket

"|" @punctuation.special

; -----------------------------------------------------------------------------
; Special patterns
; -----------------------------------------------------------------------------
; Anonymous traversal underscore
(anonymous_traversal
  "_" @variable.builtin)
