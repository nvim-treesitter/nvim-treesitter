; inherits html_tags

(element
  (start_tag
    (tag_name) @_py_script)
  (text) @injection.content
  (#any-of? @_py_script "py-script" "py-repl")
  (#set! injection.language "python"))

(script_element
  (start_tag
    (attribute
      (attribute_name) @_attr 
      (quoted_attribute_value 
        (attribute_value) @_type)))
  (raw_text) @injection.content
  (#eq? @_attr "type")
  ; not adding type="py" here as it's handled by html_tags 
  (#any-of? @_type "pyscript" "py-script")
  (#set! injection.language "python"))

(element
  (start_tag
    (tag_name) @_py_config)
  (text) @injection.content
  (#eq? @_py_config "py-config")
  (#set! injection.language "toml"))

;------ Angular queries ------

; {{ someBinding }}
((text) @injection.content 
  (#lua-match? @injection.content "%{%{.+%}%}")
  (#set! injection.language "angular")
)

; }
((text) @injection.content 
  (#lua-match? @injection.content "%}.*")
  (#set! injection.language "angular")
)

; Angular control flow statements
; @if (condition) {
((text) @injection.content 
  (#lua-match? @injection.content "%@if%s+%(.+%)%s+%{$")
  (#set! injection.language "angular")
)

; @for (item of items) {
((text) @injection.content 
  (#lua-match? @injection.content "%@for%s+%(.+%)%s+%{$")
  (#set! injection.language "angular")
)

; @switch (condition) {
((text) @injection.content 
  (#lua-match? @injection.content "%@switch%s+%(.+%)%s+%{$")
  (#set! injection.language "angular")
)

; @case (value) {
((text) @injection.content 
  (#lua-match? @injection.content "%@case%s+%(.+%)%s+%{$")
  (#set! injection.language "angular")
)

; @default {
((text) @injection.content 
  (#lua-match? @injection.content "%@default%s+%{$")
  (#set! injection.language "angular")
)

; @defer {
((text) @injection.content 
  (#lua-match? @injection.content "%@defer%s+%{$")
  (#set! injection.language "angular")
)

; @defer (conditions) {
((text) @injection.content 
  (#lua-match? @injection.content "%@defer%s+%(.+%)%{$")
  (#set! injection.language "angular")
)

; Angular continuation blocks
; } @else {
((text) @injection.content
  (#lua-match? @injection.content "%}%s+%@else%s+%{$")
  (#set! injection.language "angular")
)

; } @else if (condition) {
((text) @injection.content
  (#lua-match? @injection.content "%}%s+%@else%s+if%s+%(.+%)%s+%{$")
  (#set! injection.language "angular")
)

; } @empty {
((text) @injection.content 
  (#lua-match? @injection.content "%}%s+%@empty%s+%{$")
  (#set! injection.language "angular")
)

; } @placeholder {
((text) @injection.content
  (#lua-match? @injection.content "%}%s+%@placeholder%s+%{$")
  (#set! injection.language "angular")
)

; @placeholder (minumum) {
((text) @injection.content
  (#lua-match? @injection.content "%}%s+%@placeholder%s+%(.+%)%{$")
  (#set! injection.language "angular")
)

; } @loading {
((text) @injection.content
  (#lua-match? @injection.content "%}%s+%@loading%s+%{$")
  (#set! injection.language "angular")
)

; } @loading (conditions) {
((text) @injection.content
  (#lua-match? @injection.content "%}%s+%@loading%s+%(.+%)%s+%{$")
  (#set! injection.language "angular")
)

; } @error {
((text) @injection.content
  (#lua-match? @injection.content "%}%s+%@error%s+%{$")
  (#set! injection.language "angular")
)



