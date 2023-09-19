["%parameter" "%token" "%type" "%start" "%attribute" "%left" "%right" "%nonassoc" "%public" "%inline" "%prec"] @keyword
["%on_error_reduce"] @exception

["let"] @keyword.function

[(equality_symbol) ":" "|" ";" ","] @punctuation.delimiter

["=" "~" "_"] @operator
(modifier) @operator

["<" ">" "{" "}" "%{" "%}" "%%"] @punctuation.special

["(" ")"] @punctuation.bracket

(old_rule [(symbol)] @function)
(new_rule [(lid)] @function)

(precedence [(symbol)] @parameter)

(funcall) @function.call

; Not very accurant but does a decent job
(uid) @constant

(ocaml_type) @type
(ocaml) @none

[(comment) (line_comment) (ocaml_comment)] @comment @spell
(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
