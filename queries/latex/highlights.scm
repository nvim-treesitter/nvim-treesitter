;; Math
[
 (displayed_equation)
 (inline_formula)
] @text.math

((generic_environment
  (begin
   name: (curly_group_text
           (text) @_env))) @text.math
   (#any-of? @_env
      "displaymath" "displaymath*"
      "equation" "equation*"
      "multline" "multline*"
      "eqnarray" "eqnarray*"
      "align" "align*"
      "array" "array*"
      "split" "split*"
      "alignat" "alignat*"
      "gather" "gather*"
      "flalign" "flalign*"))

;; File inclusion commands
[
  "\\documentclass"
  "\\usepackage"
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

;; Definitions
[
  (command_name)
  "\\newcommand"
  "\\renewcommand"
  "\\DeclareRobustCommand"
  "\\DeclareMathOperator"
  "\\newglossaryentry"
  "\\caption"
  "\\label"
  "\\newlabel"
  "\\color"
  "\\colorbox"
  "\\textcolor"
  "\\pagecolor"
  "\\definecolor"
  "\\definecolorset"
  "\\newtheorem"
  "\\declaretheorem"
  "\\newacronym"
] @function.macro

;; References (labels)
[
  "\\ref"
  "\\eqref"
  "\\vref"
  "\\Vref"
  "\\autoref"
  "\\pageref"
  "\\cref"
  "\\Cref"
  "\\cref*"
  "\\Cref*"
  "\\namecref"
  "\\nameCref"
  "\\lcnamecref"
  "\\namecrefs"
  "\\nameCrefs"
  "\\lcnamecrefs"
  "\\labelcref"
  "\\labelcpageref"
  "\\crefrange"
  "\\crefrange"
  "\\Crefrange"
  "\\Crefrange"
  "\\crefrange*"
  "\\crefrange*"
  "\\Crefrange*"
  "\\Crefrange*"
] @function.macro

;; References (bibliography)
[
  "\\cite"
  "\\cite*"
  "\\Cite"
  "\\nocite"
  "\\citet"
  "\\citep"
  "\\citet*"
  "\\citep*"
  "\\citeauthor"
  "\\citeauthor*"
  "\\Citeauthor"
  "\\Citeauthor*"
  "\\citetitle"
  "\\citetitle*"
  "\\citeyear"
  "\\citeyear*"
  "\\citedate"
  "\\citedate*"
  "\\citeurl"
  "\\fullcite"
  "\\citeyearpar"
  "\\citealt"
  "\\citealp"
  "\\citetext"
  "\\parencite"
  "\\parencite*"
  "\\Parencite"
  "\\footcite"
  "\\footfullcite"
  "\\footcitetext"
  "\\textcite"
  "\\Textcite"
  "\\smartcite"
  "\\Smartcite"
  "\\supercite"
  "\\autocite"
  "\\Autocite"
  "\\autocite*"
  "\\Autocite*"
  "\\volcite"
  "\\Volcite"
  "\\pvolcite"
  "\\Pvolcite"
  "\\fvolcite"
  "\\ftvolcite"
  "\\svolcite"
  "\\Svolcite"
  "\\tvolcite"
  "\\Tvolcite"
  "\\avolcite"
  "\\Avolcite"
  "\\notecite"
  "\\notecite"
  "\\pnotecite"
  "\\Pnotecite"
  "\\fnotecite"
] @function.macro

;; References (glossary)
[
  "\\gls"
  "\\Gls"
  "\\GLS"
  "\\glspl"
  "\\Glspl"
  "\\GLSpl"
  "\\glsdisp"
  "\\glslink"
  "\\glstext"
  "\\Glstext"
  "\\GLStext"
  "\\glsfirst"
  "\\Glsfirst"
  "\\GLSfirst"
  "\\glsplural"
  "\\Glsplural"
  "\\GLSplural"
  "\\glsfirstplural"
  "\\Glsfirstplural"
  "\\GLSfirstplural"
  "\\glsname"
  "\\Glsname"
  "\\GLSname"
  "\\glssymbol"
  "\\Glssymbol"
  "\\glsdesc"
  "\\Glsdesc"
  "\\GLSdesc"
  "\\glsuseri"
  "\\Glsuseri"
  "\\GLSuseri"
  "\\glsuserii"
  "\\Glsuserii"
  "\\GLSuserii"
  "\\glsuseriii"
  "\\Glsuseriii"
  "\\GLSuseriii"
  "\\glsuseriv"
  "\\Glsuseriv"
  "\\GLSuseriv"
  "\\glsuserv"
  "\\Glsuserv"
  "\\GLSuserv"
  "\\glsuservi"
  "\\Glsuservi"
  "\\GLSuservi"
] @function.macro

;; Acronyms
[
  "\\acrshort"
  "\\Acrshort"
  "\\ACRshort"
  "\\acrshortpl"
  "\\Acrshortpl"
  "\\ACRshortpl"
  "\\acrlong"
  "\\Acrlong"
  "\\ACRlong"
  "\\acrlongpl"
  "\\Acrlongpl"
  "\\ACRlongpl"
  "\\acrfull"
  "\\Acrfull"
  "\\ACRfull"
  "\\acrfullpl"
  "\\Acrfullpl"
  "\\ACRfullpl"
  "\\acs"
  "\\Acs"
  "\\acsp"
  "\\Acsp"
  "\\acl"
  "\\Acl"
  "\\aclp"
  "\\Aclp"
  "\\acf"
  "\\Acf"
  "\\acfp"
  "\\Acfp"
  "\\ac"
  "\\Ac"
  "\\acp"
  "\\glsentrylong"
  "\\Glsentrylong"
  "\\glsentrylongpl"
  "\\Glsentrylongpl"
  "\\glsentryshort"
  "\\Glsentryshort"
  "\\glsentryshortpl"
  "\\Glsentryshortpl"
  "\\glsentryfullpl"
  "\\Glsentryfullpl"
] @function.macro

;; General syntax
[
 (line_comment)
 (block_comment)
 (comment_environment)
] @comment

(brack_group) @parameter

[(operator) "="] @operator

"\\item" @punctuation.special

((word) @punctuation.delimiter
(#eq? @punctuation.delimiter "&"))

["$" "\\[" "\\]" "\\(" "\\)"] @punctuation.delimiter

(label_definition
 name: (_) @text.reference)
(label_reference_range
 from: (_) @text.reference
 to: (_) @text.reference)
(label_reference
 names: (_) @text.reference)
(label_number
 name: (_) @text.reference
 number: (_) @text.reference)

(citation
 keys: (curly_group_text_list) @text.reference)

(key_value_pair
  key: (_) @parameter
  value: (_))

["[" "]" "{" "}"] @punctuation.bracket ; "(" ")" has no syntactical meaning in LaTeX

;; Sectioning

[
  "\\part"
  "\\chapter"
  "\\section"
  "\\subsection"
  "\\subsubsection"
  "\\paragraph"
  "\\subparagraph"

  "\\addpart"
  "\\addchap"
  "\\addsec"

  "\\part*"
  "\\chapter*"
  "\\section*"
  "\\subsection*"
  "\\subsubsection*"
  "\\paragraph*"
  "\\subparagraph*"

  "\\addpart*"
  "\\addchap*"
  "\\addsec*"
] @namespace

(chapter
  text: (curly_group) @text.title)

(part
  text: (curly_group) @text.title)

(section
  text: (curly_group) @text.title)

(subsection
  text: (curly_group) @text.title)

(subsubsection
  text: (curly_group) @text.title)

(paragraph
  text: (curly_group) @text.title)

(subparagraph
  text: (curly_group) @text.title)

(generic_environment
  (begin
    name: (curly_group_text
            (text) @text.environment.name)
    (#any-of? @text.environment.name "frame"))
  .
  (curly_group (_) @text.title))

((command
  command: (command_name) @_name
  arg: (curly_group
          (text) @text.title))
 (#eq? @_name "\\frametitle"))

;; Formatting
((command
  command: (command_name) @_name
  arg: (curly_group (_) @text.emphasis))
  (#eq? @_name "\\emph"))

((command
  command: (command_name) @_name
  arg: (curly_group (_) @text.emphasis))
  (#match? @_name "^(\\\\textit|\\\\mathit)$"))

((command
  command: (command_name) @_name
  arg: (curly_group (_) @text.strong))
  (#match? @_name "^(\\\\textbf|\\\\mathbf)$"))

((command
  command: (command_name) @_name
  .
  arg: (curly_group (_) @text.uri))
 (#match? @_name "^(\\\\url|\\\\href)$"))

;; General environments
[
  "\\begin"
  "\\end"
] @text.environment

(begin
 name: (curly_group_text
         (text) @text.environment.name)
  (#not-any-of? @text.environment.name
      "displaymath" "displaymath*"
      "equation" "equation*"
      "multline" "multline*"
      "eqnarray" "eqnarray*"
      "align" "align*"
      "array" "array*"
      "split" "split*"
      "alignat" "alignat*"
      "gather" "gather*"
      "flalign" "flalign*"))

(end
 name: (curly_group_text
         (text) @text.environment.name)
  (#not-any-of? @text.environment.name
      "displaymath" "displaymath*"
      "equation" "equation*"
      "multline" "multline*"
      "eqnarray" "eqnarray*"
      "align" "align*"
      "array" "array*"
      "split" "split*"
      "alignat" "alignat*"
      "gather" "gather*"
      "flalign" "flalign*"))

(ERROR) @error
