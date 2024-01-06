; Styled Jsx <style jsx>
(jsx_element
  (jsx_opening_element
    (identifier) @_name
    (#eq? @_name "style")
    (jsx_attribute) @_attr
    (#eq? @_attr "jsx"))
  (jsx_expression
    ((template_string) @injection.content
      (#set! injection.language "css"))
    (#offset! @injection.content 0 1 0 -1)))
