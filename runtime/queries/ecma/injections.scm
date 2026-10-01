(((comment) @_jsdoc_comment
  (#lua-match? @_jsdoc_comment "^/[*][*][^*].*[*]/$")) @injection.content
  (#set! injection.language "jsdoc"))

((comment) @injection.content
  (#set! injection.language "comment"))

; html(`...`), sql(`...`), etc.
(call_expression
  function: (identifier) @injection.language
  arguments: (arguments
    (template_string
      [
        (string_fragment) @injection.content
        (template_substitution)
      ]+))
  (#lua-match? @injection.language "^[a-zA-Z][a-zA-Z0-9]*$")
  ; Languages excluded from auto-injection due to special rules
  ; - svg uses the html parser
  ; - css uses the styled parser
  (#not-any-of? @injection.language "svg" "css"))

; html`...`, sql`...`, etc.
(call_expression
  function: (identifier) @injection.language
  arguments: (template_string
    [
      (string_fragment) @injection.content
      (template_substitution)
    ]+)
  (#lua-match? @injection.language "^[a-zA-Z][a-zA-Z0-9]*$")
  (#not-any-of? @injection.language "svg" "css"))

; svg(`...`)
(call_expression
  function: (identifier) @_name
  (#eq? @_name "svg")
  arguments: (arguments
    (template_string
      [
        (string_fragment) @injection.content
        (template_substitution)
      ]+))
  (#set! injection.language "html"))

; svg`...`
(call_expression
  function: (identifier) @_name
  (#eq? @_name "svg")
  arguments: (template_string
    [
      (string_fragment) @injection.content
      (template_substitution)
    ]+)
  (#set! injection.language "html"))

; Vercel PostgreSQL
; foo.sql(`...`)
(call_expression
  function: (member_expression
    property: (property_identifier) @injection.language)
  arguments: (arguments
    (template_string
      [
        (string_fragment) @injection.content
        (template_substitution)
      ]+))
  (#eq? @injection.language "sql"))

; foo.sql`...`
(call_expression
  function: (member_expression
    property: (property_identifier) @injection.language)
  arguments: (template_string
    [
      (string_fragment) @injection.content
      (template_substitution)
    ]+)
  (#eq? @injection.language "sql"))

; Sanity CMS GROQ query
; defineQuery(`...`)
(call_expression
  function: (identifier) @_name
  (#eq? @_name "defineQuery")
  arguments: (arguments
    (template_string
      [
        (string_fragment) @injection.content
        (template_substitution)
      ]+))
  (#set! injection.language "groq"))

; gql(`...`)
(call_expression
  function: (identifier) @_name
  (#eq? @_name "gql")
  arguments: (arguments
    (template_string
      [
        (string_fragment) @injection.content
        (template_substitution)
      ]+))
  (#set! injection.language "graphql"))

; gql`...`
(call_expression
  function: (identifier) @_name
  (#eq? @_name "gql")
  arguments: (template_string
    [
      (string_fragment) @injection.content
      (template_substitution)
    ]+)
  (#set! injection.language "graphql"))

(call_expression
  function: (identifier) @_name
  (#eq? @_name "hbs")
  arguments: (template_string
    [
      (string_fragment) @injection.content
      (template_substitution)
    ]+)
  (#set! injection.language "glimmer"))

; css`<css>`, keyframes`<css>`
(call_expression
  function: (identifier) @_name
  (#any-of? @_name "css" "keyframes")
  arguments: (template_string
    [
      (string_fragment) @injection.content
      (template_substitution)
    ]+)
  (#set! injection.language "styled"))

; styled.div`<css>`
(call_expression
  function: (member_expression
    object: (identifier) @_name
    (#eq? @_name "styled"))
  arguments: ((template_string
    [
      (string_fragment) @injection.content
      (template_substitution)
    ]+)
    (#set! injection.language "styled")))

; styled(Component)`<css>`
(call_expression
  function: (call_expression
    function: (identifier) @_name
    (#eq? @_name "styled"))
  arguments: ((template_string
    [
      (string_fragment) @injection.content
      (template_substitution)
    ]+)
    (#set! injection.language "styled")))

; styled.div.attrs({ prop: "foo" })`<css>`
(call_expression
  function: (call_expression
    function: (member_expression
      object: (member_expression
        object: (identifier) @_name
        (#eq? @_name "styled"))))
  arguments: ((template_string
    [
      (string_fragment) @injection.content
      (template_substitution)
    ]+)
    (#set! injection.language "styled")))

; styled(Component).attrs({ prop: "foo" })`<css>`
(call_expression
  function: (call_expression
    function: (member_expression
      object: (call_expression
        function: (identifier) @_name
        (#eq? @_name "styled"))))
  arguments: ((template_string
    [
      (string_fragment) @injection.content
      (template_substitution)
    ]+)
    (#set! injection.language "styled")))

((regex_pattern) @injection.content
  (#set! injection.language "regex"))

; ((comment) @_gql_comment
;   (#eq? @_gql_comment "/* GraphQL */")
;   (template_string) @injection.content
;   (#set! injection.language "graphql"))
((template_string
  (string_fragment) @injection.content)
  (#lua-match? @injection.content "^#graphql")
  (#set! injection.combined)
  (#set! injection.language "graphql"))

; el.innerHTML = `<html>`
(assignment_expression
  left: (member_expression
    property: (property_identifier) @_prop
    (#any-of? @_prop "outerHTML" "innerHTML"))
  right: (template_string
    [
      (string_fragment) @injection.content
      (template_substitution)
    ]+)
  (#set! injection.language "html"))

; el.innerHTML = '<html>'
(assignment_expression
  left: (member_expression
    property: (property_identifier) @_prop
    (#any-of? @_prop "outerHTML" "innerHTML"))
  right: (string
    (string_fragment) @injection.content)
  (#set! injection.language "html"))

;---- Angular injections -----
; @Component({
;   template: `<html>`
; })
(decorator
  (call_expression
    function: ((identifier) @_name
      (#eq? @_name "Component"))
    arguments: (arguments
      (object
        (pair
          key: ((property_identifier) @_prop
            (#eq? @_prop "template"))
          value: ((template_string
            [
              (string_fragment) @injection.content
              (template_substitution)
            ]+)
            (#set! injection.language "angular")))))))

; @Component({
;   styles: [`<css>`]
; })
(decorator
  (call_expression
    function: ((identifier) @_name
      (#eq? @_name "Component"))
    arguments: (arguments
      (object
        (pair
          key: ((property_identifier) @_prop
            (#eq? @_prop "styles"))
          value: (array
            ((template_string
              [
                (string_fragment) @injection.content
                (template_substitution)
              ]+)
              (#set! injection.language "css"))))))))

; @Component({
;   styles: `<css>`
; })
(decorator
  (call_expression
    function: ((identifier) @_name
      (#eq? @_name "Component"))
    arguments: (arguments
      (object
        (pair
          key: ((property_identifier) @_prop
            (#eq? @_prop "styles"))
          value: ((template_string
            [
              (string_fragment) @injection.content
              (template_substitution)
            ]+)
            (#set! injection.language "css")))))))
