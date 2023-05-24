[
 (select_expression)
 (cte)
 (column_definitions)
 (case)
 (keyword_when)
 (keyword_else)
 (subquery)
] @indent.begin


(compound_statement
  (keyword_begin)
  (statement) @indent.begin
)

(column_definitions "(" @indent.begin)
(column_definitions ")" @indent.branch)
(subquery ")" @indent.branch)
(subquery "(" @indent.begin)

[
 (keyword_end)
] @indent.branch

 (keyword_from) @indent.align
