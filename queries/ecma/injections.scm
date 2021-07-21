(comment) @jsdoc
(comment) @comment

(call_expression
  function: ((identifier) @language)
  arguments: ((template_string) @content
              (#offset! @content 0 1 0 -1)))

(call_expression
  function: ((identifier) @_name
             (#eq? @_name "gql"))
  arguments: ((template_string) @graphql
              (#offset! @graphql 0 1 0 -1)))

(call_expression
  function: ((identifier) @_name
             (#eq? @_name "hbs"))
  arguments: ((template_string) @glimmer
              (#offset! @glimmer 0 1 0 -1)))

(regex_pattern) @regex
