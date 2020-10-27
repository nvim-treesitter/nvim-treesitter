((comment) @injection
 (#set! "lang" "jsdoc"))

(call_expression
  function: ((identifier) @matches
             (#eq? @matches "gql"))
  arguments: (template_string) @injection
   (#set! "lang" "graphql"))
