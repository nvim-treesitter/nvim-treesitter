(((comment) @_jsdoc_comment
  (#lua-match? @_jsdoc_comment "^/[*][*][^*].*[*]/$")) @injection.content
  (#set! injection.language "jsdoc"))

((comment) @injection.content
 (#set! injection.language "comment"))

; html(`...`), html`...`, sql(...) etc
(call_expression
 function: ((identifier) @injection.language)
 arguments: [
             (arguments
              (template_string) @injection.content)
             (template_string) @injection.content
            ]
     (#lua-match? @injection.language "^[a-zA-Z][a-zA-Z0-9]*$")
     (#offset! @injection.content 0 1 0 -1)
     (#not-eq? @injection.language "svg"))

; svg`...` or svg(`...`), which uses the html parser, so is not included in the previous query
(call_expression
 function: ((identifier) @_name (#eq? @_name "svg"))
 arguments: [
             (arguments
              (template_string) @injection.content)
             (template_string) @injection.content
            ]
     (#offset! @injection.content 0 1 0 -1)
     (#set! injection.language "html"))


(call_expression
 function: ((identifier) @_name
   (#eq? @_name "gql"))
 arguments: ((template_string) @injection.content
   (#offset! @injection.content 0 1 0 -1)
   (#set! injection.language "graphql")))

(call_expression
 function: ((identifier) @_name
   (#eq? @_name "hbs"))
 arguments: ((template_string) @injection.content
   (#offset! @injection.content 0 1 0 -1)
   (#set! injection.language "glimmer")))

((glimmer_template) @injection.content
 (#set! injection.language "glimmer"))

; styled.div`<css>`
(call_expression
 function: (member_expression
   object: (identifier) @_name
     (#eq? @_name "styled"))
 arguments: ((template_string) @injection.content
   (#offset! @injection.content 0 1 0 -1)
   (#set! injection.language "css")))

; styled(Component)`<css>`
(call_expression
 function: (call_expression
   function: (identifier) @_name
     (#eq? @_name "styled"))
 arguments: ((template_string) @injection.content
   (#offset! @injection.content 0 1 0 -1)
   (#set! injection.language "css")))

; styled.div.attrs({ prop: "foo" })`<css>`
(call_expression
 function: (call_expression
   function: (member_expression
    object: (member_expression
      object: (identifier) @_name
        (#eq? @_name "styled"))))
 arguments: ((template_string) @injection.content
   (#offset! @injection.content 0 1 0 -1)
   (#set! injection.language "css")))


; styled(Component).attrs({ prop: "foo" })`<css>`
(call_expression
 function: (call_expression
   function: (member_expression
    object: (call_expression
      function: (identifier) @_name
        (#eq? @_name "styled"))))
 arguments: ((template_string) @injection.content
   (#offset! @injection.content 0 1 0 -1)
   (#set! injection.language "css")))

((regex_pattern) @injection.content
 (#set! injection.language "regex"))

; ((comment) @_gql_comment
;   (#eq? @_gql_comment "/* GraphQL */")
;   (template_string) @injection.content
;   (#set! injection.language "graphql"))

((template_string) @injection.content
  (#lua-match? @injection.content "^`#graphql")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "graphql"))

; el.innerHTML = `<html>`
(assignment_expression
  left: 
    (member_expression
      property: (property_identifier) @_prop
      (#any-of? @_prop "outerHTML" "innerHTML"))
  right: (template_string) @injection.content
    (#offset! @injection.content 0 1 0 -1)
    (#set! injection.language "html"))

; el.innerHTML = '<html>'
(assignment_expression
  left: 
    (member_expression
      property: (property_identifier) @_prop
      (#any-of? @_prop "outerHTML" "innerHTML"))
  right: 
    (string (string_fragment) @injection.content)
    (#set! injection.language "html"))
