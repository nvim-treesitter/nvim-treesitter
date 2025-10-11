(line_continuation) @punctuation.special

(comment
  (comment_content) @spell) @comment

[
  (pixel)
  (percentage)
  (number)
] @number

[
  "steps"
  "cubic-bezier"
] @function.call

(boolean) @boolean

(color) @constant

(string) @string

[
  (ctrl)
  (alt)
  (shift)
  (function)
  (super)
  (mouse_button)
  (up)
  (left)
  (right)
  (middle)
  (down)
] @constant.builtin

[
  "+"
  ">"
  ":"
  "-"
  (separator)
  "="
  ","
  "'"
] @punctuation.delimiter

[
  "("
  ")"
] @punctuation.bracket

(special) @variable.builtin

(key) @character

(path) @string.special.path

(label) @label

(constant) @constant

(direction) @constant

(pattern) @string.regexp

(flag) @constant

((string) @constant
  (#lua-match? @constant "^-"))

(generic_action) @function.call

(action_name) @function.call

[
  "pt"
  "px"
  "%"
  "ratio"
  (signal_name)
  (clear_target)
  (ligature_target)
  (window_location)
  (stdin_source)
  (marker_type)
  (window_state)
  (logo_position)
  (mouse_selection_type)
  (window_layout)
  (os_window)
  "ignore-shell"
  (detach_into)
  "@selection"
  (kitty_shell_open_as)
  (mouse_event)
  (font_modification_type)
  (ease_step_position)
  "c"
  (filter_element_type)
  "all"
  (ligature_disabled)
  (clipboard_action)
  (shell_feature)
  (source_strategy)
  (notification_time)
  (paste_action)
  (pointer)
  (layout)
  (launch_type_value)
  (os_window_class)
  (layout_type)
  (time_suffix)
  (cursor)
  (spacing_type)
  (remote_action)
  (font_feature)
] @type

(kitten
  target: (string) @type)

[
  (color_option_name)
  "map"
  "mouse_map"
  (option_name)
] @keyword

(open_url
  value: (string) @string.special.url)

(handle_click_actions
  _ @type)

(title) @string.special

(font_change_amount
  sign: (font_change_sign) @operator)

(aliased_action
  name: (string) @function.call)

(set_colors
  "set_colors" @function.call)

(include
  environment_variable: (string) @variable.builtin)

(key_focus_on
  condition: (string) @string.special)

(mouse_mode
  [
    "grabbed"
    "ungrabbed"
  ] @variable.parameter)

(font_property
  name: (string) @variable.parameter)

(url_excluded_characters
  value: (string) @character)

(transparent_color
  "@" @punctuation.special
  (alpha) @number)

(env
  variable: (string) @variable.builtin)

(boolean_operator) @keyword.operator

(notification_action) @function.call
