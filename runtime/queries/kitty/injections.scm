(launch_source_window
  pattern: (string) @injection.content
  (#set! injection.language "regex"))

(launch_next_to
  pattern: (string) @injection.content
  (#set! injection.language "regex"))

(marker_entry
  pattern: (string) @injection.content
  (#set! injection.language "regex"))

(color_match
  (string) @injection.content
  (#set! injection.language "regex"))

(color_match_tab
  (string) @injection.content
  (#set! injection.language "regex"))

(include
  glob: (string) @injection.content
  (#set! injection.language "regex"))

(filter_element
  (string) @injection.content
  (#set! injection.language "regex"))
