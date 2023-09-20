; highlights.scm
((identifier) @keyword
 (#any-of? @keyword "definition" "permission" "relation"))

((permission_literal) @variable.builtin)

(permission (identifier) @type)
(relation (identifier) @constant)
(perm_expression (identifier) @property)
((block_start) @punctuation.bracket)
((block_end) @punctuation.bracket)

(block (identifier) (identifier) @constructor)

((plus_literal) @operator)
((hash_literal) @comment)

; relations
((relation_literal) @function)
(rel_expression (identifier) @property)


((pipe_literal) @operator)

(relation
  (rel_expression
    (
      (hash_literal)
      .
      (identifier) @constant) @comment))


(permission
  (perm_expression
    (
      (stabby)
      .
      (identifier) @function) @operator))

((comment) @comment)
