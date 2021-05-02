;; Fish highlighting

;; Operators

[
 "&&"
 "||"
 "|"
 "&"
 "="
 "!="
 ".."
 "!"
 (direction)
 (stream_redirect)
] @operator

[
 "not"
 "and"
 "or"
] @keyword.operator

;; Conditionals

(if_statement
[
 "if"
 "end"
] @conditional)

(switch_statement
[
 "switch"
 "end"
] @conditional)

(case_clause
[
 "case"
] @conditional)

(else_clause 
[
 "else"
] @conditional)

(else_if_clause 
[
 "else"
 "if"
] @conditional)

;; Loops/Blocks

(while_statement
[
 "while"
 "end"
] @repeat)

(for_statement
[
 "for"
 "end"
] @repeat)

(begin_statement
[
 "begin"
 "end"
] @repeat)

;; Keywords

[
 "in"
 "return"
 (break)
 (continue)
] @keyword

;; Punctuation

[
 "["
 "]"
 "{"
 "}"
 "("
 ")"
] @punctuation.bracket

"," @punctuation.delimiter

;; Commands

(command
  argument: [
             (word) @parameter (#match? @parameter "^-")
            ]
)

; non-bultin command names
(command name: (word) @function)

; derived from builtin -n (fish 3.2.2)
(command
  name: [
        (word) @function.builtin
        (#match? @function.builtin "^(.|:|_|alias|argparse|bg|bind|block|breakpoint|builtin|cd|command|commandline|complete|contains|count|disown|echo|emit|eval|exec|exit|fg|functions|history|isatty|jobs|math|printf|pwd|random|read|realpath|set|set_color|source|status|string|test|time|type|ulimit|wait)$")
        ]
)


;; Functions

(function_definition ["function" "end"] @keyword.function)

(function_definition
  name: [
        (word) (concatenation)
        ] 
@function)

(function_definition
  option: [
          (word)
          (concatenation (word))
          ] @parameter (#match? @parameter "^-")
)

;; Strings

[(double_quote_string) (single_quote_string)] @string
(escape_sequence) @string.escape

;; Variables

(variable_name) @variable
(variable_expansion) @constant

;; Nodes

[(integer) (float)] @number
(comment) @comment
(test_option) @string

((word) @boolean
(#match? @boolean "^(true|false)$"))

;; Error

(ERROR) @error

