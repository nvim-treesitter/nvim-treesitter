(comment) @jsdoc
(comment) @comment

; {lang}`<{lang}>`
(call_expression
 function: ((identifier) @language)
 arguments: ((template_string) @content
   (#offset! @content 0 1 0 -1)
   (#inject_without_any_children! @content)))

; gql`<graphql>`
(call_expression
 function: ((identifier) @_name
   (#eq? @_name "gql"))
 arguments: ((template_string) @graphql
   (#offset! @graphql 0 1 0 -1)
   (#inject_without_any_children! @graphql)))

; hbs`<glimmer>`
(call_expression
 function: ((identifier) @_name
   (#eq? @_name "hbs"))
 arguments: ((template_string) @glimmer
   (#offset! @glimmer 0 1 0 -1)
   (#inject_without_any_children! @glimmer)))

; styled.div`<css>`
(call_expression
 function: (member_expression
   object: (identifier) @_name
     (#eq? @_name "styled"))
 arguments: ((template_string) @css
   (#offset! @css 0 1 0 -1)
   (#inject_without_any_children! @css)))

; styled(Component)`<css>`
(call_expression
 function: (call_expression
   function: (identifier) @_name
     (#eq? @_name "styled"))
 arguments: ((template_string) @css
   (#offset! @css 0 1 0 -1)
   (#inject_without_any_children! @css)))

; styled.div.attrs({ prop: "foo" })`<css>`
(call_expression
 function: (call_expression
   function: (member_expression
    object: (member_expression
      object: (identifier) @_name
        (#eq? @_name "styled"))))
 arguments: ((template_string) @css
   (#offset! @css 0 1 0 -1)
   (#inject_without_any_children! @css)))

; styled(Component).attrs({ prop: "foo" })`<css>`
(call_expression
 function: (call_expression
   function: (member_expression
    object: (call_expression
      function: (identifier) @_name
        (#eq? @_name "styled"))))
 arguments: ((template_string) @css
   (#offset! @css 0 1 0 -1)
   (#inject_without_any_children! @css)))

; createGlobalStyle`<css>`
(call_expression
 function: (identifier) @_name
   (#eq? @_name "createGlobalStyle")
 arguments: ((template_string) @css
   (#offset! @css 0 1 0 -1)
   (#inject_without_any_children! @css)))

(regex_pattern) @regex
