;; By @alexlafroscia (https://github.com/alexlafroscia/tree-sitter-glimmer)
;; Licensed under MIT
;; Modified for nvim-treesitter

; Tags that start with a lower case letter are HTML tags
((tag_name) @tag
  (#match? @tag "^[a-z]"))
; Tags that start with a capital letter are Glimmer components
((tag_name) @constructor
  (#match? @constructor "^[A-Z]"))

(attribute_name) @property

(string_literal) @string
(number_literal) @number
(boolean_literal) @boolean

; == Mustache Statements ===

; Hightlight the whole statement, to color brackets and separators
(mustache_statement) @tag.delimiter

; Generic identifiers are variables
(identifier) @variable
; Helpers are functions
;TODO: does not exist
;;(helper_identifier) @function

(comment_statement) @comment

(attribute_node "=" @operator)

(block_params "as" @keyword)
(block_params "|" @operator)

[
  "<"
  ">"
  "</"
  "/>"
] @tag.delimiter
