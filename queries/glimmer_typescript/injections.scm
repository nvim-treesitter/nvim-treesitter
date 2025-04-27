; inherits: typescript

; Ember Unified <template> syntax
; e.g.: <template><SomeComponent @arg={{double @value}} /></template>
((glimmer_template) @injection.content
  (#set! injection.language "glimmer")
  (#set! injection.include-children))
