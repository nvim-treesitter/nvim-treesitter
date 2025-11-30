; folds.scm - Folding queries for TOON
; Allows collapsing nested structures in editors
; Fold objects (nested key-value structures)
(pair
  value: (object)) @fold

; Fold array declarations with content
(array_declaration
  content: (array_content)) @fold

; Fold root arrays with content
(root_array
  content: (array_content)) @fold

; Fold list items with nested objects
(list_item
  (object)) @fold
