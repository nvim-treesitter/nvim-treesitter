;; Scopes

(document) @scope

(directive) @scope

;; Definitions

(substitution_definition
  name: (substitution) @definition)

(footnote
  name: (label) @definition)

(citation
  name: (label) @definition)

(target
  name: (reference) @definition)

; Inline targets
(target) @definition

;; References

[
 (substitution_reference)
 (footnote_reference)
 (citation_reference)
 (reference)
] @reference
