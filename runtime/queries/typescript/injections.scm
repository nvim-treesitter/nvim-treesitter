; inherits: ecma

; styled.div<{}>`<css>`
(call_expression
  function: (non_null_expression
    (instantiation_expression
      (member_expression
        object: (identifier) @_name
        (#eq? @_name "styled")
        property: (property_identifier))
      type_arguments: (type_arguments)))
  arguments: ((template_string) @injection.content
    (#offset! @injection.content 0 1 0 -1)
    (#set! injection.include-children)
    (#set! injection.language "styled")))

; styled.div<T>`<css>`
(binary_expression
  left: (binary_expression
    left: (member_expression
      object: (identifier) @_name
      (#eq? @_name "styled")
      property: (property_identifier))
    right: (identifier))
  right: (template_string) @injection.content
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
  (#set! injection.language "styled"))
