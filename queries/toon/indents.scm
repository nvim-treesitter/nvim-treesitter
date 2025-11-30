; indents.scm - Indentation queries for TOON
; Guides automatic indentation in editors
; Indent after opening a nested object
(pair
  value: (object) @indent.begin)

; Indent after array declaration with content
(array_declaration
  content: (array_content) @indent.begin)

; Indent after root array with content
(root_array
  content: (array_content) @indent.begin)

; Indent inside list items with nested content
(list_item
  (object) @indent.begin)

; Dedent at end of objects/arrays (handled by external scanner)
; These markers indicate where indentation should decrease
(object) @indent.end

(array_content) @indent.end
