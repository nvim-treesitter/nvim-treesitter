;; Forked from tree-sitter-regex
;; The MIT License (MIT) Copyright (c) 2014 Max Brunsfeld
[
 "("
 ")"
 "(?"
 "(?:"
 "(?<"
 ">"
 "["
 "]" 
 "{" 
 "}"
] @punctuation.bracket

(group_name) @property

[
 (identity_escape)
 (control_letter_escape)
 (character_class_escape)
 (control_escape)
 (start_assertion)
 (end_assertion)
 (boundary_assertion)
 (non_boundary_assertion)
] @string.escape

[ "*" "+" "|" "=" "<=" "!" "<!" ] @operator
