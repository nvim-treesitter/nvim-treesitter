; highlights.scm
((identifier) @keyword
 (#match? @keyword "^(definition|permission|relation)$"))

((permission_literal) @variable.builtin)

(permission (identifier) @type)
(relation (identifier) @constant)
(perm_expression (identifier) @property)
((block_start) @punctuation)
((block_end) @punctuation)

(block (identifier) (identifier) @constructor)

((plus_literal) @punctuation)
((hash_literal) @comment)

; relations
((relation_literal) @function)
(rel_expression (identifier) @property)


((pipe_literal) @punctuation)

(relation
  (rel_expression
    (
  (hash_literal)
  .
  (identifier) @constant
  ) @coment))


(permission
 (perm_expression
   (
    (stabby)
    .
    (identifier)
    @function) @punctuation))

((comment) @comment)
