; inherits: typescript

; Parse Ember/Glimmer/Handlebars/HTMLBars/etc. template literals
; e.g.: await render(hbs`<SomeComponent />`)
(call_expression
  function: ((identifier) @_name
    (#eq? @_name "hbs"))
  arguments: ((template_string) @glimmer
    (#offset! @glimmer 0 1 0 -1)))

; Ember Unified <template> syntax
; e.g.: <template><SomeComponent @arg={{double @value}} /></template>
((glimmer_template) @injection.content
  (#set! injection.language "glimmer")
  (#set! injection.include-children))
