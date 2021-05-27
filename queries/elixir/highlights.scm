(identifier) @variable

; _unused variables
(unused_identifier) @comment

; __MODULE__ and friends
(special_identifier) @constant.builtin

(module) @type

[(atom) (keyword)] @symbol

(integer) @number
(float) @float

[(true) (false)] @boolean

(nil) @constant.builtin

(comment) @comment

[
  ","
  "."
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
  "<<"
  ">>"
] @punctuation.bracket

(interpolation
 "#{" @punctuation.special
 "}" @punctuation.special) @none

[
  (heredoc_content)
  (sigil_content)
  (string_content)
  (string_end)
  (string_start)
] @string

[
  (heredoc_end)
  (heredoc_start)
  (sigil_end)
  (sigil_start)
] @string.special

(escape_sequence) @string.escape

[
  "after"
  "do"
  "end"
] @keyword

[
  "and"
  "in"
  "not"
  "not in"
  "or"
] @keyword.operator

; Call to a local function
(call (function_identifier) @method)

; Call to a remote (or external) function
(dot_call
 remote: [(atom) (module)] @type
 function: (function_identifier) @method)

"fn" @keyword.function

; def, defp, defguard, ... everything that starts with def
(call (function_identifier) @keyword.function
 (#lua-match? @keyword.function "^def%a*$"))

(call (function_identifier) @keyword.function
 (#any-of? @keyword.function "describe" "doctest" "on_exit" "setup" "setup_all" "test"))

"else" @conditional

(call (function_identifier) @conditional
 (#any-of? @conditional "case" "cond" "if" "unless" "with"))

(call (function_identifier) @repeat
 (#eq? @repeat "for"))

(call (function_identifier) @include
 (#any-of? @include "alias" "import" "require" "use"))

[
  "catch"
  "rescue"
] @exception

(call (function_identifier) @exception
 (#any-of? @exception "raise" "try"))

; Regex sigil
(sigil
 (sigil_start) @_sigil-type
 [(sigil_content) (escape_sequence)] @string.regex
 (sigil_end)
 (#lua-match? @_sigil-type "^~r"))

"->" @operator

(unary_op
 operator: _ @operator)

(binary_op
 operator: _ @operator)

(unary_op
 operator: "@" @attribute
 [(call
   function: (function_identifier) @attribute)
  (identifier) @attribute])

(unary_op
 operator: "@"
 (call (function_identifier) @attribute
       (heredoc
        [(heredoc_start)
         (heredoc_content)
         (heredoc_end)] @string))
 (#any-of? @attribute "doc" "moduledoc"))

(unary_op
 operator: "@"
 (call (function_identifier) @attribute
       (binary_op
        left: (identifier) @method))
 (#eq? @attribute "spec"))

; Definition without arguments
(call (function_identifier) @keyword.function
 (identifier) @function 
 (#lua-match? @keyword.function "^def%a*$"))

; Definition with (some) arguments and (optional) defaults
(call (function_identifier) @keyword.function
 (call
  function: (function_identifier) @function
  (arguments
   [(identifier) @parameter
    (tuple (identifier) @parameter)
    (list (identifier) @parameter)
    (_
     (keyword_list (identifier) @parameter))
    (binary_op
     left: (identifier) @parameter
     operator: "\\\\")]))
 (#lua-match? @keyword.function "^def%a*$"))

; Definition with (some) arguments and guard(s)
(call (function_identifier) @keyword.function
 (binary_op
  left:
   (call
    function: (function_identifier) @function
    (arguments
     [(identifier) @parameter
      (tuple (identifier) @parameter)
      (list (identifier) @parameter)
      (_
       (keyword_list (identifier) @parameter))]))
  operator: "when")
 (#lua-match? @keyword.function "^def%a*$"))

; Definition of custom binary operator(s)
(call (function_identifier) @keyword.function
 (binary_op
  left: (identifier) @parameter
  operator: _ @function
  right: (identifier) @parameter)
 (#any-of? @keyword.function "def" "defp"))

(ERROR) @error
