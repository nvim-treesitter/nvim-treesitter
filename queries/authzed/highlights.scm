((identifier) @keyword
 (#any-of? @keyword "definition" "permission" "relation"))

(permission_literal) @variable.builtin

(permission (identifier) @type)
(relation (identifier) @constant)
(perm_expression (identifier) @property)

[
  (block_start)
  (block_end)
] @punctuation.bracket

(block (identifier) (identifier) @constructor)

[
  (plus_literal)
  (pipe_literal)
] @operator

(relation_literal) @function
(rel_expression (identifier) @property)

(relation
  (rel_expression
    ((hash_literal)
     . (identifier) @constant) @comment))

(permission
  (perm_expression
    ((stabby)
     . (identifier) @function) @operator))

[
  (hash_literal)
  (comment)
] @comment
