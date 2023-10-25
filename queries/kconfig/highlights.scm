"source" @include

[
  "mainmenu"
  "config"
  "menuconfig"
  "choice"
  "endchoice"
  "comment"
  "menu"
  "endmenu"
  "prompt"
  "default"
  "range"
  "help"
  (optional)
  (modules)
] @keyword

[
  "if"
  "endif"
  "depends on"
  "select"
  "imply"
  "visible if"
] @conditional

[
  "def_bool"
  "def_tristate"
] @keyword.function

[
  "||"
  "&&"
  "="
  "!="
  "<"
  ">"
  "<="
  ">="
  "!"
] @operator

[
  "bool"
  "tristate"
  "int"
  "hex"
  "string"
] @type.builtin

[ "(" ")" ] @punctuation.bracket

(macro_variable ["$(" ")"] @punctuation.special)

(symbol) @variable

[
  (prompt)
  (macro_content)
  (text)
] @string

(config name: (symbol) @constant)
(menuconfig name: (symbol) @constant)
(choice name: (symbol) @constant)

((symbol) @constant
  (#lua-match? @constant "[A-Z0-9]+"))

(mainmenu name: (prompt) @text.title)
(comment_entry name: (prompt) @text.title)
(menu name: (prompt) @text.title)

(source (prompt) @text.uri @string.special)

(comment) @comment @spell
