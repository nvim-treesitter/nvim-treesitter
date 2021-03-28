;; Math
[
 (displayed_equation)
 (inline_formula)
] @text.math

;; This highlights the whole environment like vimtex does
((environment
  (begin
   name: (word) @_env)) @text.math
   (#match? @_env "^(displaymath|eqn|eqnarray|align)[*]?$"))

;; This at the begining of the file would be the alternative to highlight
;; only the interior of the environment
;((environment
  ;(begin
   ;name: (word) @_env) @none
   ;(end) @none) @text.math
   ;(#match? @_env "^(displaymath|eqn|eqnarray)[*]?$"))

[
  (generic_command_name)
  "\\begin"
  "\\end"
  "\\newcommand"
  "\\renewcommand"
  "\\DeclareRobustCommand"
  "\\caption"
] @function.macro

(comment) @comment

(bracket_group) @parameter

[(math_operator) "="] @operator

[
  "\\usepackage"
  "\\documentclass"
  "\\input"
  "\\subfile"
  "\\subfileinclude"
  "\\subfileinclude"
  "\\includegraphics"
  "\\addbibresource"
  "\\bibliography"
  "\\includesvg"
  "\\includeinkscape"
  "\\usepgflibrary"
  "\\usetikzlibrary"
] @include

[
  "\\chapter"
  "\\section"
  "\\subsection"
  "\\subsubsection"
  "\\paragraph"
  "\\subparagraph"
] @type

"\\item" @punctuation.special

((word) @punctuation.delimiter
(#eq? @punctuation.delimiter "&"))

[
  (label_definition)
  (label_reference)
  (equation_label_reference)
  (label_number)
] @label

(key_val_pair
  key: (_) @parameter
  value: (_))

["(" ")" "[" "]" "{" "}"] @punctuation.bracket

(chapter
  text: (brace_group) @text.title)

(section
  text: (brace_group) @text.title)

(subsection
  text: (brace_group) @text.title)

(subsubsection
  text: (brace_group) @text.title)

(paragraph
  text: (brace_group) @text.title)

(subparagraph
  text: (brace_group) @text.title)

((environment
  (begin
   name: (word) @_frame)
   (brace_group
        child: (text) @text.title))
 (#eq? @_frame "frame"))

((generic_command
  name:(generic_command_name) @_name
  arg: (brace_group
          (text) @text.title))
 (#eq? @_name "\\frametitle"))

;; Formatting

((generic_command
  name:(generic_command_name) @_name
  arg: (_) @text.emphasis)
 (#eq? @_name "\\emph"))

((generic_command
  name:(generic_command_name) @_name
  arg: (_) @text.emphasis)
 (#match? @_name "^(\\textit|\\mathit)$"))

((generic_command
  name:(generic_command_name) @_name
  arg: (_) @text.strong)
 (#match? @_name "^(\\textbf|\\mathbf)$"))

((generic_command
  name:(generic_command_name) @_name
  .
  arg: (_) @text.url)
 (#match? @_name "^(\\url|\\href)$"))

(ERROR) @error

