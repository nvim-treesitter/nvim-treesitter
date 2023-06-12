; highlights.scm
[
  "|"
  "|["
  "]"
  "("
  ")"
  "|("
  ")|"
] @punctuation.bracket

[
  ","
  ";"
  ":"
] @punctuation.delimiter

"EXTERNAL" @keyword

"out of" @property

(number) @number

(identifier) @variable

(version) @string.special

(anonymous_block) @string

(limit) @property

(time) @function

(limit
  (identifier) @string)

(event_detail
  (event_detail_value) @string)

(log_level_setting
  (component) @type)

(log_level_setting
  (log_level) @constant)

(log_entry
  (event_identifier
    (identifier) @type))
