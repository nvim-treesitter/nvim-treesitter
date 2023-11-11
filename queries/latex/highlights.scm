; General syntax
(command_name) @function

(text_mode
  "\\text" @function)

(caption
  command: _ @function)

(key_value_pair
  key: (_) @variable.parameter
  value: (_))

[
  (line_comment)
  (block_comment)
  (comment_environment)
] @comment @spell

((line_comment) @keyword.directive
  (#lua-match? @keyword.directive "^%% !TeX"))

[
  (brack_group)
  (brack_group_argc)
] @variable.parameter

[
  (operator)
  "="
  "_"
  "^"
] @operator

"\\item" @punctuation.special

((word) @punctuation.delimiter
  (#eq? @punctuation.delimiter "&"))

[
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket ; "(" ")" has no syntactical meaning in LaTeX

; General environments
(begin
  command: _ @markup.environment
  name:
    (curly_group_text
      (text) @markup.environment.name))

(end
  command: _ @markup.environment
  name:
    (curly_group_text
      (text) @markup.environment.name))

; Definitions and references
(new_command_definition
  command: _ @function.macro
  declaration:
    (curly_group_command_name
      (_) @function))

(old_command_definition
  command: _ @function.macro
  declaration: (_) @function)

(let_command_definition
  command: _ @function.macro
  declaration: (_) @function)

(environment_definition
  command: _ @function.macro
  name:
    (curly_group_text
      (_) @markup.link))

(theorem_definition
  command: _ @function.macro
  name:
    (curly_group_text
      (_) @markup.environment.name))

(paired_delimiter_definition
  command: _ @function.macro
  declaration:
    (curly_group_command_name
      (_) @function))

(label_definition
  command: _ @function.macro
  name:
    (curly_group_text
      (_) @markup.link))

(label_reference_range
  command: _ @function.macro
  from:
    (curly_group_text
      (_) @markup.link)
  to:
    (curly_group_text
      (_) @markup.link))

(label_reference
  command: _ @function.macro
  names:
    (curly_group_text_list
      (_) @markup.link))

(label_number
  command: _ @function.macro
  name:
    (curly_group_text
      (_) @markup.link)
  number: (_) @markup.link)

(citation
  command: _ @function.macro
  keys: (curly_group_text_list) @markup.link)

(glossary_entry_definition
  command: _ @function.macro
  name:
    (curly_group_text
      (_) @markup.link))

(glossary_entry_reference
  command: _ @function.macro
  name:
    (curly_group_text
      (_) @markup.link))

(acronym_definition
  command: _ @function.macro
  name:
    (curly_group_text
      (_) @markup.link))

(acronym_reference
  command: _ @function.macro
  name:
    (curly_group_text
      (_) @markup.link))

(color_definition
  command: _ @function.macro
  name:
    (curly_group_text
      (_) @markup.link))

(color_reference
  command: _ @function.macro
  name:
    (curly_group_text
      (_) @markup.link))

; Formatting
(text_mode
  content:
    (curly_group
      (_) @none @spell))

; Math
[
  (displayed_equation)
  (inline_formula)
] @markup.math

(math_environment
  (begin
    command: _ @markup.math
    name:
      (curly_group_text
        (_) @markup.math)))

(math_environment
  (_) @markup.math)

(math_environment
  (end
    command: _ @markup.math
    name:
      (curly_group_text
        (_) @markup.math)))

; Sectioning
(title_declaration
  command: _ @module
  options:
    (brack_group
      (_) @markup.heading.1)?
  text:
    (curly_group
      (_) @markup.heading.1))

(author_declaration
  command: _ @module
  authors:
    (curly_group_author_list
      (author)+ @markup.heading.1))

(chapter
  command: _ @module
  toc:
    (brack_group
      (_) @markup.heading.2)?
  text:
    (curly_group
      (_) @markup.heading.2))

(part
  command: _ @module
  toc:
    (brack_group
      (_) @markup.heading.2)?
  text:
    (curly_group
      (_) @markup.heading.2))

(section
  command: _ @module
  toc:
    (brack_group
      (_) @markup.heading.3)?
  text:
    (curly_group
      (_) @markup.heading.3))

(subsection
  command: _ @module
  toc:
    (brack_group
      (_) @markup.heading.4)?
  text:
    (curly_group
      (_) @markup.heading.4))

(subsubsection
  command: _ @module
  toc:
    (brack_group
      (_) @markup.heading.5)?
  text:
    (curly_group
      (_) @markup.heading.5))

(paragraph
  command: _ @module
  toc:
    (brack_group
      (_) @markup.heading.6)?
  text:
    (curly_group
      (_) @markup.heading.6))

(subparagraph
  command: _ @module
  toc:
    (brack_group
      (_) @markup.heading.6)?
  text:
    (curly_group
      (_) @markup.heading.6))

; Beamer frames
(generic_environment
  (begin
    name:
      (curly_group_text
        (text) @markup.environment.name)
    (#any-of? @markup.environment.name "frame"))
  .
  (curly_group
    (_) @markup.heading))

((generic_command
  command: (command_name) @_name
  arg:
    (curly_group
      (text) @markup.heading))
  (#eq? @_name "\\frametitle"))

((generic_command
  command: (command_name) @_name
  arg:
    (curly_group
      (_) @markup.italic))
  (#eq? @_name "\\emph"))

((generic_command
  command: (command_name) @_name
  arg:
    (curly_group
      (_) @markup.italic))
  (#any-of? @_name "\\textit" "\\mathit"))

((generic_command
  command: (command_name) @_name
  arg:
    (curly_group
      (_) @markup.strong))
  (#any-of? @_name "\\textbf" "\\mathbf"))

((generic_command
  command: (command_name) @_name
  .
  arg:
    (curly_group
      (_) @markup.link.url))
  (#any-of? @_name "\\url" "\\href"))

; File inclusion commands
(class_include
  command: _ @keyword.import
  path: (curly_group_path) @string)

(package_include
  command: _ @keyword.import
  paths: (curly_group_path_list) @string)

(latex_include
  command: _ @keyword.import
  path: (curly_group_path) @string)

(import_include
  command: _ @keyword.import
  directory: (curly_group_path) @string
  file: (curly_group_path) @string)

(bibtex_include
  command: _ @keyword.import
  path: (curly_group_path) @string)

(biblatex_include
  "\\addbibresource" @keyword.import
  glob: (curly_group_glob_pattern) @string.regexp)

(graphics_include
  command: _ @keyword.import
  path: (curly_group_path) @string)

(tikz_library_import
  command: _ @keyword.import
  paths: (curly_group_path_list) @string)

(text) @spell

(inline_formula) @nospell

(displayed_equation) @nospell

(key_value_pair) @nospell

(generic_environment
  begin: _ @nospell
  end: _ @nospell)

(citation
  keys: _ @nospell)

(command_name) @nospell

(label_definition) @nospell

(label_reference) @nospell

(label_reference_range) @nospell
