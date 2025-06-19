; inherits: html

((php_only) @injection.content
  (#set! injection.language "php_only"))

((parameter) @injection.content
  (#set! injection.include-children)
  (#set! injection.language "php_only"))

((text) @injection.content
  (#has-ancestor? @injection.content "envoy")
  (#set! injection.combined)
  (#set! injection.language bash))

; Livewire attributes
; <div wire:click="baz++">
(attribute
  (attribute_name) @_attr
  (#any-of? @_attr "wire:model" "wire:click" "wire:stream" "wire:text" "wire:show")
  (quoted_attribute_value
    (attribute_value) @injection.content)
  (#set! injection.language "javascript"))

; AlpineJS attributes
; <div x-data="{ foo: 'bar' }" x-init="baz()">
(attribute
  (attribute_name) @_attr
  (#lua-match? @_attr "^x%-%l+")
  (#not-any-of? @_attr "x-teleport" "x-ref" "x-transition")
  (quoted_attribute_value
    (attribute_value) @injection.content)
  (#set! injection.language "javascript"))

(attribute
  (attribute_name) @_attr
  (#lua-match? @_attr "^[:@]%l+")
  (quoted_attribute_value
    (attribute_value) @injection.content)
  (#set! injection.language "javascript"))

; Blade escaped JS attributes
; <x-foo ::bar="baz" />
(element
  (_
    (tag_name) @_tag
    (#lua-match? @_tag "^x%-%l+")
    (attribute
      (attribute_name) @_attr
      (#lua-match? @_attr "^::%l+")
      (quoted_attribute_value
        (attribute_value) @injection.content)
      (#set! injection.language "javascript"))))

; Blade PHP attributes
; <x-foo :bar="$baz" />
(element
  (_
    (tag_name) @_tag
    (#lua-match? @_tag "^x%-%l+")
    (attribute
      (attribute_name) @_attr
      (#lua-match? @_attr "^:%l+")
      (quoted_attribute_value
        (attribute_value) @injection.content)
      (#set! injection.language "php_only"))))
