; Extra Nodes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(line_continuation) @comment

; Primitive data types ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
[
  (pixel)
  (percentage)
  (number)
] @number

(pixel
  "px" @type)

(percentage
  "%" @type)

[
  (boolean)
  "enabled"
  "disabled"
] @boolean

(layout_type) @type

;
; Hexadecimal colors.
(color) @constant

; Color names & `none`.
((color) @constant
  (#match? @constant "^[^#]"))

;
(string) @string

(time
  duration: (number) @number
  suffix: (time_suffix) @type)

;
[
  (ctrl)
  (alt)
  (shift)
  (function)
  (super)
  (mouse_button)
  (left)
  (right)
  (middle)
] @constant.builtin

[
  "+"
  ">"
] @punctuation.delimiter

(special) @variable.builtin

(key) @character

; Actions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(generic_action) @function.call

(action_name) @function.call

(copy_to_buffer
  buffer: (string) @character)

(paste_from_buffer
  buffer: (string) @character)

;
(keyboard_mode
  "," @punctuation.delimiter)

(keyboard_mode
  [
    "normal"
    "application"
    "kitty"
    "all"
  ] @constant)

;
(show_kitty_doc
  topic: (string) @label)

(signal_child
  signal: (signal_name) @type)

(clear_terminal
  action: (clear_action) @constant
  target: (clear_target) @type)

;
(combine_action
  (separator) @punctuation.delimiter)

;
(disable_ligatures_in
  target: (ligature_target) @type
  type: (ligature_disabled) @constant)

(kitten
  target: (string) @type)

; Command flags(`--flag`) should be highlighted *differently*.
(kitten_arguments
  (string) @variable.parameter
  (#match? @variable.parameter "^-"))

; Launch ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(flag) @constant

"=" @punctuation.delimiter

(launch_type
  type: _ @type)

(launch_source_window
  pattern: (string) @string.regex)

(launch_cwd
  directory: (string) @string.special.path)

(launch_env
  variable: (string) @variable.builtin)

(launch_var
  variable: (string) @variable.builtin)

(launch_window_location
  location: (window_location) @type)

(launch_next_to
  pattern: (string) @string.regex)

;
(launch_remote_password
  [
    "'"
    "\""
  ] @punctuation.delimiter)

(launch_remote_password
  password: (password) @string.special)

(remote_actions
  (string) @constant.macro)

;
(launch_stdin_source
  source: (stdin_source) @type)

;
(markers
  type: (marker_type) @type)

(marker_entry
  id: (marker_id) @label
  pattern: (string) @string.regex)

;
(launch_os_window_class
  class: (string) @type)

(launch_os_window_name
  name: (string) @string.special)

(launch_os_window_title
  title: (string) @string.special)

(launch_os_window_state
  state: (window_state) @type)

(launch_logo
  path: (string) @string.special.path)

(launch_logo_position
  position: (logo_position) @type)

(launch_color
  name: (color_option_name) @variable.builtin)

(launch_spacing
  name: (string) @variable.builtin)

; OS Panel ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; `option` may include any of the `os_panel_*` nodes.
; The first child of these nodes are **always** the
; option name.
(launch_os_panel
  option: (_
    (option) @variable.builtin))

;
(launch_watcher
  path: (string) @string.special.path)

;
(load_config_file
  path: (string)? @string.special.path)

(open_url
  url: (string) @string.special.url)

(remote_control_script
  path: (string) @string.special.path)

;
(handle_click_actions
  _ @type)

;
(mouse_selection
  selection: (mouse_selection_type) @type)

(scroll_to_prompt
  prompt_number: (number) @number
  lines_above: (number)? @operator)

(goto_tab
  tab: (number) @label)

(set_tab_title
  title: (title)? @string.special)

(set_window_title
  title: (title) @string.special)

(move_window
  direction: (direction) @constant)

(neighboring_window
  direction: (direction) @constant)

(nth_window
  window: (number) @label)

(resize_window
  layout: (window_layout) @type)

(change_font_size
  target: (os_window) @type)

(font_change_amount
  sign: (font_change_sign)? @operator)

(close_window_with_confirmation
  "ignore-shell"? @type)

(detach_window
  into: (detach_into)? @type)

((background_alpha) @constant
  (#eq? @constant "default"))

(nth_os_window
  window: (number) @label)

;
(goto_layout
  ":" @punctuation.delimiter)

; Strings are mostly pre-defined keywords.
(layout_option
  value: (string) @constant)

;
(aliased_action
  name: (string) @function.call)

(pass_selection_to_program
  program: (string) @string.special)

(new_window
  program: (string)? @string.special
  "@selection"? @type)

(kitty_shell
  open_as: (kitty_shell_open_as)? @type)

; Colors ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set_colors
  "set_colors" @function.call)

(color_match
  (string) @string.regex)

(color_match_tab
  (string) @string.regex)

;
(color_option
  name: (color_option_name) @keyword)

(color_value
  .
  (color_data
    path: (string) @string.special.path))

(color_data
  name: (color_option_name) @variable.builtin)

; Includes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(include
  "include" @keyword
  path: (string) @string.special.path)

(include
  "globinclude" @keyword
  glob: (string) @string.regex)

(include
  "geninclude" @keyword
  path: (string) @string.special.path)

(include
  "envinclude" @keyword
  environment_variable: (string) @variable.builtin)

; Keyboard shortcut ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(keyboard_shortcut
  "map" @keyword)

(key_focus_on
  "--when-focus-on" @constant
  condition: (string) @string.special)

; Mouse shortcuts ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(mouse_shortcut
  "mouse_map" @keyword
  event_type: (mouse_event) @type)

(mouse_mode
  [
    "grabbed"
    "ungrabbed"
  ] @variable.parameter)

(mouse_mode
  "," @punctuation.delimiter)

; Options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(option_name) @keyword

;
(font_value
  (string) @string.special)

(font_value
  .
  (string) @constant
  (#any-of? @constant "auto" "monospace" "bold" "italic" "bold-italic") .)

(font_property
  name: (string) @variable.parameter
  "=" @punctuation.delimiter)

;
(symbol_map
  codepoints: (string) @constant
  font_name: (string) @string.special)

(narrow_symbols
  codepoints: (string) @constant)

;
(font_features
  font: (string)? @constant)

(font_features
  "none" @constant)

(feature_list
  (string) @string.special)

;
(modify_font
  type: (font_modification_type) @type)

(undercurl_style
  "-" @punctuation.delimiter)

(undercurl_style
  [
    "thin"
    "thick"
    "sparse"
    "dense"
  ] @constant)

;
((composition_value) @constant
  (#eq? @constant "platform"))

;
(fg_override_threshold
  [
    "ratio"
    "%"
  ] @type)

;
(cursor) @type

;
((ease) @type
  (#match? @type "^[a-z-]$"))

(ease_step
  "steps" @function.call)

(ease_step
  [
    "("
    ")"
  ] @punctuation.bracket)

(ease_step
  "," @punctuation.delimiter)

(ease_step
  position: (ease_step_position) @type)

(cubic_bezier
  "cubic-bezier" @function.call)

(cubic_bezier
  [
    "("
    ")"
  ] @punctuation.bracket)

(cubic_bezier
  "," @punctuation.delimiter)

;
(scrollback_pager
  command: (string) @string.special)

;
(url_prefix_list
  (string) @constant)

;
(url_excluded_characters
  characters: (string) @string.special)

;
(paste_action_list
  "," @punctuation.delimiter)

(paste_action) @type

;
(pointer) @type

;
(layout_list
  "," @punctuation.delimiter)

(layout) @type

;
(border_width
  [
    "px"
    "pt"
  ] @type)

;
(scale_value
  "," @punctuation.delimiter)

;
(transparent_color
  "@" @punctuation.special
  (alpha) @number)

;
(remote_control_password
  password: (string) @string.special)

(remote_actions
  (string) @type)

;
(env
  variable: (string) @variable.builtin
  "=" @punctuation.delimiter)

((filter_sequence) @constant
  (#eq? @constant "all"))

(boolean_expression) @operator

(filter_element
  [
    "title"
    "body"
    "app"
    "type"
  ] @parameter
  ":" @punctuation.delimiter
  (string) @string.regex)

(filter_element
  "\"" @punctuation.delimiter)

;
(clipboard_action) @type

;
((shell_features) @constant
  (#eq? @constant "enabled"))

((shell_features) @constant
  (#eq? @constant "disabled"))

(shell_feature) @type

;
(source_stratagies
  "," @punctuation.delimiter)

(source_strategy) @type

;
(notification_time) @type

(notification_action) @function.call

(notification_action
  "command"
  command: (string) @string.special)

;
(menu_map
  value: (string) @string.special)

;
((titlebar_color) @constant
  (#eq? @constant "system"))

((titlebar_color) @constant
  (#eq? @constant "background"))

;
(confirm_os_window_close
  count_background: (string) @constant)

;
(initial_window_size
  [
    "initial_window_width"
    "initial_window_height"
  ] @keyword)

(initial_window_size
  "c" @type)

(action_alias
  [
    "action_alias"
    "kitten_alias"
  ] @keyword
  name: (string) @string.special)

; Comment ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(comment) @comment @spell
