(object_id) @variable

(string) @string

(escape_sequence) @string.escape

(comment) @comment @spell

(constant) @constant.builtin

(boolean) @boolean

(using) @keyword.import

(template) @keyword

(decorator) @attribute

(property_definition
  (property_name) @property)

(object) @type

(signal_binding
  (signal_name) @function.builtin)

(signal_binding
  (function
    (identifier)) @function)

(signal_binding
  "swapped" @keyword)

(styles_list
  "styles" @function.macro)

(layout_definition
  "layout" @function.macro)

(gettext_string
  "_" @function.builtin)

(menu_definition
  "menu" @keyword)

(menu_section
  "section" @keyword)

(menu_item
  "item" @function.macro)

(import_statement
  (gobject_library) @module)

(import_statement
  (version_number) @number.float)

(float) @number.float

(number) @number

[
  ";"
  "."
  ","
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket
