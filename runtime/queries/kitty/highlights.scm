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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Hexadecimal colors.
(color) @constant

; Color names & `none`.
((color) @constant
  (#match? @constant "^[^#]"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(string) @string

(time
  duration: (number) @number
  suffix: (time_suffix) @type)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

(copy_to_buffer
  "copy_to_buffer" @function.call
  buffer: (string) @character)

(paste_from_buffer
  "paste_from_buffer" @function.call
  buffer: (string) @character)

(send_key
  "send_key" @function.call)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(send_text
  "send_text" @function.call)

(keyboard_mode
  "," @punctuation.delimiter)

(keyboard_mode
  [
    "normal"
    "application"
    "kitty"
    "all"
  ] @constant)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(show_kitty_doc
  "show_kitty_doc" @function.call
  topic: (string) @label)

(signal_child
  "signal_child" @function.call
  signal: (signal_name) @type)

(clear_terminal
  "clear_terminal" @function.call
  action: (clear_action) @constant
  target: (clear_target) @type)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(combine
  "combine" @function.call)

(combine_action
  (separator) @punctuation.delimiter)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(disable_ligatures_in
  "disable_ligatures_in" @function.call
  target: (ligature_target) @type
  type: (ligature_disabled) @constant)


(kitten
  "kitten" @function.call
  target: (string) @type)

; Command flags(`--flag`) should be highlighted *differently*.
(kitten_arguments
  (string) @variable.parameter
  (#match? @variable.parameter "^-"))

;; Launch ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(launch
  "launch" @function.call)

(launch_source_window
  "--source-window" @constant
  pattern: (string) @string.regex)

(launch_window_title
  [
    "--title"
    "--window-title"
  ] @constant)

(launch_tab_title
  "--tab-title" @constant)

(launch_type
  "--type" @constant
  "=" @punctuation.delimiter
  _ @type)

(launch_focus
  [
    "--dont-take-focus"
    "--keep-focus"
  ] @constant
  "="? @punctuation.delimiter
  _? @type)

(launch_cwd
  "--cwd" @constant
  "=" @punctuation.delimiter
  directory: (string) @string.special.path)

(launch_env
  "--env" @constant

  variable: (string) @variable.builtin
  "=" @punctuation.delimiter
  value: (string) @string)

(launch_var
  "--var" @constant

  variable: (string) @variable.builtin
  "=" @punctuation.delimiter
  value: (string) @string)

(launch_hold
  "--hold" @constant
  "="? @punctuation.delimiter
  _? @type)

(launch_copy_colors
  "--copy-colors" @constant
  "="? @punctuation.delimiter
  _? @type)

(launch_copy_cmd
  "--copy-cmd" @constant
  "="? @punctuation.delimiter
  _? @type)

(launch_copy_env
  "--copy-env" @constant
  "="? @punctuation.delimiter
  _? @type)

(launch_window_location
  "--location" @constant
  "=" @punctuation.delimiter
  location: (window_location) @type)

(launch_next_to
  "--next-to" @constant
  pattern: (string) @string.regex)

(launch_bias
  "--bias" @constant)

(launch_remote_control
  "--allow-remote-control" @constant
  "="? @punctuation.delimiter
  _? @type)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(launch_remote_password
  "--remote-control-password" @constant)

(launch_remote_password
  [
   "'"
   "\""
  ] @punctuation.delimiter)

(launch_remote_password
  password: (password) @string.special)

(remote_actions
  (string) @constant.macro) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(launch_stdin_source
  "--stdin-source" @constant
  "=" @punctuation.delimiter
  source: (stdin_source) @type)

(launch_stdin_formatting
  "--stdin-add-formatting" @constant
  "="? @punctuation.delimiter
  _? @type)

(launch_stdin_line_wrap
  "--stdin-add-line-wrap-markers" @constant
  "="? @punctuation.delimiter
  _? @type)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(launch_marker
  "--marker" @constant)

(markers
  type: (marker_type) @type)

(marker_entry
  id: (marker_id) @label
  pattern: (string) @string.regex)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(launch_os_window_class
  "--os-window-class" @constant
  class: (string) @type)

(launch_os_window_name
  "--os-window-name" @constant
  name: (string) @string.special)

(launch_os_window_title
  "--os-window-title" @constant
  title: (string) @string.special)

(launch_os_window_state
  "--os-window-state" @constant
  state: (window_state) @type)

(launch_logo
  "--logo" @constant
  path: (string) @string.special.path)

(launch_logo_position
  "--logo-position" @constant
  position: (logo_position) @type)

(launch_logo_alpha
  "--logo-alpha" @constant)

(launch_color
  "--color" @constant
  name: (color_option_name) @variable.builtin
  "=" @punctuation.delimiter)

(launch_spacing
  "--spacing" @constant
  name: (string) @variable.builtin
  "=" @punctuation.delimiter)

;;; OS Panel ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; `option` may include any of the `os_panel_*` nodes.
; The first child of these nodes are **always** the 
; option name.
(launch_os_panel
  "--os-panel" @constant
  option: (_
    _ @variable.builtin
    "=" @punctuation.delimiter))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(launch_watcher
  [
    "--watcher"
    "-w"
  ] @constant
  path: (string) @string.special.path)

(launch_hold_after_ssh
  "--hold-after-ssh" @constant
  "="? @punctuation.delimiter
  _? @type)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load_config_file
  "load_config_file" @function.call
  path: (string)? @string.special.path)

(open_url
  "open_url" @function.call
  url: (string) @string.special.url)

(remote_control_script
  "remote_control_script" @function.call
  path: (string) @string.special.path)

(sleep
  "sleep" @function.call)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(mouse_handle_click
  "mouse_handle_click" @function.call)

(handle_click_actions
  _ @type)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(mouse_selection
  "mouse_selection" @function.call
  selection: (mouse_selection_type) @type)

(scroll_prompt_to_top
  "scroll_prompt_to_top" @function.call
  "y"? @boolean)

(scroll_to_prompt
  "scroll_to_prompt" @function.call
  prompt_number: (number) @number
  lines_above: (number)? @operator)

(goto_tab
  "goto_tab" @function.call
  tab: (number) @label)

(set_tab_title
  "set_tab_title" @function.call
  title: (title)? @string.special)

(set_window_title
  "set_window_title" @function.call
  title: (title) @string.special)

(move_window
  "move_window" @function.call
  direction: (direction) @constant)

(neighboring_window
  "neighboring_window" @function.call
  direction: (direction) @constant)

(nth_window
  "nth_window" @function.call
  window: (number) @label)

(resize_window
  "resize_window" @function.call
  layout: (window_layout) @type)

(change_font_size
  "change_font_size" @function.call
  target: (os_window) @type)

(font_change_amount
  sign: (font_change_sign)? @operator)

(close_window_with_confirmation
  "close_window_with_confirmation" @function.call
  "ignore-shell"? @type)

(detach_window
  "detach_window" @function.call
  into: (detach_into)? @type)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set_background_opacity
  "set_background_opacity" @function.call)

((background_alpha) @constant
  (#eq? @constant "default"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(nth_os_window
  "nth_os_window" @function.call
  window: (number) @label)

(toggle_layout
  "toggle_layout" @function.call
  name: (layout_name)? @type)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(goto_layout
  "goto_layout" @function.call
  name: (layout_name) @type
  ":"? @punctuation.delimiter)

; Only color known option values
(layout_option
  name: (string) @variable.parameter
  (#match? @variable.parameter "^(bias|full_size|mirrored|split_axis)$")
  "=" @punctuation.delimiter)

; Strings are mostly pre-defined keywords.
(layout_option
  value: (string) @constant)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(remote_control
  "remote_control" @function.call)

(aliased_action
  name: (string) @function.call)

(pass_selection_to_program
  "pass_selection_to_program" @function.call
  program: (string) @string.special)

(new_window
  "new_window" @function.call
  program: (string)? @string.special
  "@selection"? @type)

(kitty_shell
  "kitty_shell" @function.call
  open_as: (kitty_shell_open_as)? @type)

; Colors ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set_colors
  "set_colors" @function.call)

(color_all
  [
    "-a"
    "--all"
  ] @constant
  "="? @punctuation.delimiter
  "no"? @boolean)

(color_configured
  [
    "-c"
    "--configured"
  ] @constant
  "="? @punctuation.delimiter
  "no"? @boolean)

(color_reset
  "--reset" @constant
  "="? @punctuation.delimiter
  "no"? @boolean)

(color_match
  [
   "-m"
    "--match"
  ] @constant
  (string) @string.regex)

(color_match_tab
  [
   "-t"
    "--match-tab"
  ] @constant
  (string) @string.regex)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

(numeric_option
  [
    "font_size"
    "underline_exclusion"
    "cursor_beam_thickness"
    "cursor_underline_thickness"
    "cursor_stop_blinking_after"
    "cursor_trail"
    "cursor_trail_start_threshold"
    "scrollback_lines"
    "scrollback_indicator_opacity"
    "scrollback_pager_history_size"
    "wheel_scroll_multiplier"
    "wheel_scroll_min_lines"
    "touch_scroll_multiplier"
    "click_interval"
    "repaint_delay"
    "input_delay"
    "initial_window_width"
    "initial_window_height"
    "window_resize_step_cells"
    "window_resize_step_lines"
    "inactive_text_alpha"
    "tab_bar_min_tabs"
    "tab_title_max_length"
    "background_tint"
    "background_tint_gaps"
    "dim_opacity"
    "background_opacity"
    "background_blur"
    "window_logo_alpha"
    "background_tint"
    "tab_bar_margin_width"
    "tab_bar_min_tabs"
    "update_check_interval"
    "macos_thicken_font"
    "macos_menubar_title_max_length"
    "visual_bell_duration"

    "clipboard_max_size"
  ] @keyword)

(boolean_option
  [
    "force_ltr"
    "scrollback_fill_enlarged_window"
    "detect_urls"
    "show_hyperlink_targets"
    "clear_selection_on_clipboard_loss"
    "focus_follows_mouse"
    "clear_all_mouse_actions"
    "sync_to_monitor"
    "enable_audio_bell"
    "window_alert_on_bell"
    "remember_window_position"
    "draw_minimal_borders"
    "resize_in_steps"
    "background_image_linear"
    "close_on_child_death"
    "forward_stdio"
    "macos_option_as_alt"
    "macos_hide_from_tasks"
    "macos_quit_when_last_window_closed"
    "macos_window_resizable"
    "macos_traditional_fullscreen"
    "macos_custom_beam_cursor"
    "wayland_enable_ime"
    "clear_all_shortcuts"
    "remember_window_size"

    "dynamic_background_opacity"
    "allow_hyperlinks"
  ] @keyword)

(string_option
  [
    "select_by_word_characters"
    "select_by_word_characters_forward"
    "bell_on_tab"
    "visual_window_select_characters"
    "tab_separator"
    "tab_title_template"
    "active_tab_title_template"
    "background_image"
    "shell"
    "editor"
    "listen_on"
    "watcher"
    "exe_search_path"
    "startup_session"
    "file_transfer_confirmation_bypass"
    "term"

    "strip_trailing_spaces"
    "pointer_options"
    "command_on_bell"
    "bell_path"
    "linux_bell_theme"
    "placement_strategy"
    "hide_window_decorations"
    "window_logo_position"
    "tab_bar_edge"
    "tab_bar_style"
    "tab_bar_align"
    "tab_switch_strategy"
    "tab_powerline_style"
    "tab_activity_symbol"
    "active_tab_font_style"
    "inactive_tab_font_style"
    "background_image_layout"
    "allow_remote_control"
    "allow_cloning"
    "terminfo_type"
    "macos_titlebar_color"
    "macos_show_window_title_in"
    "macos_colorspace"
    "linux_display_server"
    "disable_ligatures"
    "url_style"
    "open_url_with"
    "underline_hyperlinks"
    "copy_on_select"
    "pointer_shape_when_grabbed"
    "default_pointer_shape"
    "window_logo_path"
    "tab_bar_background"
  ] @keyword)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(font_option
  [
    "font_family"
    "bold_font"
    "italic_font"
    "bold_italic_font"
  ] @keyword)

(font_value
  (string) @string.special)

(font_value
  .
  (string) @constant
  (#eq? @constant "auto")
  .)

(font_property
  name: (string) @variable.parameter
  "=" @punctuation.delimiter)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(symbol_map
  "symbol_map" @keyword
  codepoints: (string) @constant
  font_name: (string) @string.special)

(narrow_symbols
  "narrow_symbols" @keyword
  codepoints: (string) @constant)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(font_features
  "font_features" @keyword
  font: (string)? @constant)

(font_features
  "none" @constant)

(feature_list
  (string) @string.special)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(modify_font
  "modify_font" @keyword
  type: (font_modification_type) @type)

(undercurl_style
  "undercurl_style" @keyword
  "-" @punctuation.delimiter)

(undercurl_style
  [
    "thin"
    "thick"
    "sparse"
    "dense"
  ] @constant)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(text_composition_strategy
  "text_composition_strategy" @keyword)

((composition_value) @constant
  (#eq? @constant "platform"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(text_fg_override_threshold
  "text_fg_override_threshold" @keyword)

(fg_override_threshold
  [
    "ratio"
    "%"
  ] @type)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(cursor_shape
  "cursor_shape" @keyword)

(cursor) @type

(cursor_shape_unfocused
  "cursor_shape_unfocused" @keyword)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(cursor_blink_interval
  "cursor_blink_interval" @keyword)

((ease) @type
  (#match? @type "^\w+$"))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(cursor_trail_decay
  "cursor_trail_decay" @keyword)

(scrollback_pager
  "scrollback_pager" @keyword
  command: (string) @string.special) 

(mouse_hide_wait
  "mouse_hide_wait" @keyword)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(url_prefixes
  "url_prefixes" @keyword)

(url_prefix_list
  (string) @constant)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(url_excluded_characters
  "url_excluded_characters" @keyword
  characters: (string) @string.special)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(paste_actions
  "paste_actions" @keyword)

(paste_action_list
  "," @punctuation.delimiter)

(paste_action) @type

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(pointer_shape_when_dragging
  "pointer_shape_when_dragging" @keyword)

(pointer) @type

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(visual_bell_color
  "visual_bell_color" @keyword)

(enabled_layouts
  "enabled_layouts" @keyword)

(layout_list
  "," @punctuation.delimiter)

(layout) @type

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(window_border_width
  "window_border_width" @keyword)

(border_width
  [
    "px"
    "pt"
  ] @type)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(box_drawing_scale
  "box_drawing_scale" @keyword)

(scale_value
  "," @punctuation.delimiter)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(window_margin_width
  "window_margin_width" @keyword)

(single_window_margin_width
  "single_window_margin_width" @keyword)

(window_padding_width
  "window_padding_width" @keyword)

(single_window_padding_width
  "single_window_padding_width" @keyword)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(resize_debounce_time
  "resize_debounce_time" @keyword)

(tab_bar_margin_height
  "tab_bar_margin_height" @keyword)

(tab_fade
  "tab_fade" @keyword)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(transparent_background_colors
  "transparent_background_colors" @keyword)

(transparent_color
  "@" @punctuation.special
  (alpha) @number)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(remote_control_password
  "remote_control_password" @keyword
  password: (string) @string.special)

(remote_actions
  (string) @type)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(env
  "env" @keyword
  variable: (string) @variable.builtin
  "=" @punctuation.delimiter)

(filter_notification
  "filter_notification" @keyword)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(clipboard_control
  "clipboard_control" @keyword)

(clipboard_action) @type

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(shell_integration
  "shell_integration" @keyword)

((shell_features) @constant
  (#eq? @constant "enabled"))

((shell_features) @constant
  (#eq? @constant "disabled"))

(shell_feature) @type

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(clone_source_strategies
  "clone_source_strategies" @keyword)

(source_stratagies
  "," @punctuation.delimiter)

(source_strategy) @type

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(notify_on_cmd_finish
  "notify_on_cmd_finish" @keyword)

(notification_time) @type

(notification_action) @function.call

(notification_action
  "command"
  command: (string) @string.special)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(menu_map
  "menu_map" @keyword
  value: (string) @string.special)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(wayland_titlebar_color
  "wayland_titlebar_color" @keyword)

((titlebar_color) @constant
  (#eq? @constant "system"))

((titlebar_color) @constant
  (#eq? @constant "background"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(window_logo_scale
  "window_logo_scale" @keyword)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(confirm_os_window_close
  "confirm_os_window_close" @keyword)

(confirm_os_window_close
  count_background: (string) @constant)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(kitty_mod
  "kitty_mod" @keyword)

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

(comment) @comment
