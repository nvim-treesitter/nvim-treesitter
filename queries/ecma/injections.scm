(comment) @jsdoc
(comment) @comment

((regex_pattern) @regex)

((call_expression
  function: (identifier) @_lang
  arguments: (template_string) @content)
 (#offset! @content 0 1 0 -1)
 (#inject! @_lang))

(regex_pattern) @regex
