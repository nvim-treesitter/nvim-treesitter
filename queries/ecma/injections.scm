(comment) @jsdoc
(comment) @comment

; {lang}`<{lang}>`
(call_expression
 function: ((identifier) @language)
 arguments: ((template_string) @content
   (#ecma_template_literal! @content)))

; gql`<graphql>`
(call_expression
 function: ((identifier) @_name
   (#eq? @_name "gql"))
 arguments: ((template_string) @graphql
   (#ecma_template_literal! @graphql)))

; hbs`<glimmer>`
(call_expression
 function: ((identifier) @_name
   (#eq? @_name "hbs"))
 arguments: ((template_string) @glimmer
   (#ecma_template_literal! @glimmer)))

; styled.div`<css>`
(call_expression
 function: (member_expression
   object: (identifier) @_name
     (#eq? @_name "styled"))
 arguments: ((template_string) @css
   (#ecma_template_literal! @css)))

; styled(Component)`<css>`
(call_expression
 function: (call_expression
   function: (identifier) @_name
     (#eq? @_name "styled"))
 arguments: ((template_string) @css
   (#ecma_template_literal! @css)))

; styled.div.attrs({ prop: "foo" })`<css>`
(call_expression
 function: (call_expression
   function: (member_expression
    object: (member_expression
      object: (identifier) @_name
        (#eq? @_name "styled"))))
 arguments: ((template_string) @css
   (#ecma_template_literal! @css)))

; styled(Component).attrs({ prop: "foo" })`<css>`
(call_expression
 function: (call_expression
   function: (member_expression
    object: (call_expression
      function: (identifier) @_name
        (#eq? @_name "styled"))))
 arguments: ((template_string) @css
   (#ecma_template_literal! @css)))

; createGlobalStyle`<css>`
(call_expression
 function: (identifier) @_name
   (#eq? @_name "createGlobalStyle")
 arguments: ((template_string) @css
   (#ecma_template_literal! @css)))

(regex_pattern) @regex
