[
  (generic_command_name)
  "\\begin"
  "\\end"
  "\\newcommand"
  "\\renewcommand"
  "\\DeclareRobustCommand"
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

(ERROR) @error

;; Controversial
; Add @text.bullet?
"\\item" @punctuation.special

;; Math (TODO)
;(displayed_equation)
;(inline_formula)
