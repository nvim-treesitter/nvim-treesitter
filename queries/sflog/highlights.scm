;; highlights.scm

(number) @number
(identifier) @variable
(version) @number.readonly
(namespace) @namespace

(limit) @property
(limit (identifier) @string)
(limit (number) @number)

(duration (number) @number.readonly) @string
(location (number) @number.readonly) @string

(event_detail (event_detail_value) @string)

(log_level_settings) @comment
(log_level_setting (component) @type)
(log_level_setting (log_level) @constant)

(log_entry (timestamp (time) @function) @number)
(log_entry (location) @number)
(log_entry (event_identifier (identifier) @type) @keyword)
