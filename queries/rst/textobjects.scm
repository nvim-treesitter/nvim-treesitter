(directive
  body: (body) @function.inner) @function.outer

(section (title) @class.inner) @class.outer

(transition) @class.outer

[
  (bullet_list)
  (enumerated_list)
  (definition_list)
  (field_list)

  (literal_block)
  (line_block)
  (block_quote)
  (doctest_block)
] @block.outer

(footnote
  body: (body) @block.inner) @block.outer

(citation
  body: (body) @block.inner) @block.outer

(target
  link: (link) @block.inner) @block.outer

(substitution_definition
  body: (body) @block.inner) @block.outer

(comment) @comment.outer
