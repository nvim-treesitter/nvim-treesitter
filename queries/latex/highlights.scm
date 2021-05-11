;; Math
[
 (displayed_equation)
 (inline_formula)
] @text.math

;; This highlights the whole environment like vimtex does
((environment
  (begin
   name: (word) @_env)) @text.math
   (#match? @_env "^(displaymath|equation|multline|eqnarray|align|array|split)[*]?$"))

;; This at the beginning of the file would be the alternative to highlight
;; only the interior of the environment
;((environment
  ;(begin
   ;name: (word) @_env) @none
   ;(end) @none) @text.math
   ;(#match? @_env "^(displaymath|eqn|eqnarray)[*]?$"))

[
  (generic_command_name)
  "\\newcommand"
  "\\renewcommand"
  "\\DeclareRobustCommand"
  "\\DeclareMathOperator"
  "\\newglossaryentry"
  "\\caption"
  "\\cite"
  "\\label"
  "\\newlabel"
  "\\label"
  "\\ref"
  "\\cref"
  "\\eqref"
  "\\color"
  "\\colorbox"
  "\\textcolor"
  "\\pagecolor"
  "\\definecolor"
  "\\definecolorset"
  "\\newtheorem"
  "\\declaretheorem"
  "\\newacronym"
  "\\newglossaryentry"
] @function.macro

(comment) @comment

(bracket_group) @parameter

[(math_operator) "="] @operator

[
  "\\usepackage"
  "\\documentclass"
  "\\input"
  "\\include"
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
  "\\part"
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

["$" "\\[" "\\]" "\\(" "\\)"] @punctuation.delimiter

(label_definition
 name: (_) @text.reference)
(label_reference
 label: (_) @text.reference)
(equation_label_reference
 label: (_) @text.reference)
(label_reference
 label: (_) @text.reference)
(label_number
 label: (_) @text.reference)

(citation
 key: (word) @text.reference)

(key_val_pair
  key: (_) @parameter
  value: (_))

["[" "]" "{" "}"] @punctuation.bracket ;"(" ")" is has no special meaning in LaTeX

(chapter
  text: (brace_group) @text.title)

(part
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
 (#match? @_name "^(\\\\textit|\\\\mathit)$"))

((generic_command
  name:(generic_command_name) @_name
  arg: (_) @text.strong)
 (#match? @_name "^(\\\\textbf|\\\\mathbf)$"))

((generic_command
  name:(generic_command_name) @_name
  .
  arg: (_) @text.uri)
 (#match? @_name "^(\\\\url|\\\\href)$"))

(ERROR) @error

[
  "\\begin"
  "\\end"
] @text.environment

(begin
 name: (_) @text.environment.name
 (#not-match? @text.environment.name "^(displaymath|equation|multline|eqnarray|align|array|split)[*]?$"))
(end
 name: (_) @text.environment.name
 (#not-match? @text.environment.name "^(displaymath|equation|multline|eqnarray|align|array|split)[*]?$"))
