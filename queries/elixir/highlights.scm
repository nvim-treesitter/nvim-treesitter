(identifier) @variable

(interpolation
 "#{" @punctuation.special
 "}" @punctuation.special) @none

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

(call (function_identifier) @method)

(call (function_identifier) @keyword
 (#any-of? @keyword
  "quote"
  "receive"
  "self"
  "super"
  "unquote"
  "unquote_splicing"
  "with"
  "assert"
  "assert_in_delta"
  "assert_raise"
  "assert_receive"
  "assert_received"
  "catch_error"
  "catch_exit"
  "catch_throw"
  "flunk"
  "refute"
  "refute_in_delta"
  "refute_receive"
  "refute_received"))

"fn" @keyword.function

(call (function_identifier) @keyword.function
 (#lua-match? @keyword.function "^def%a*$"))

(call (function_identifier) @keyword.function
 (#any-of? @keyword.function "describe" "doctest" "on_exit" "setup" "setup_all" "test"))

"else" @conditional

(call (function_identifier) @conditional
 (#any-of? @conditional "case" "cond" "if" "unless"))

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

(sigil
 (sigil_start) @_sigil-type
 [(sigil_content) (escape_sequence)] @string.regex
 (sigil_end)
 (#lua-match? @_sigil-type "^~r"))

(module) @type

[(atom) (keyword)] @symbol

(escape_sequence) @string.escape
(integer) @number
(float) @float

[(true) (false)] @boolean

(nil) @constant.builtin

(comment) @comment

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

(dot_call
 remote: [(atom) (module)] @type
 function: (function_identifier) @method)

(call (function_identifier) @keyword.function
      [(call
        (function_identifier) @function)
       (call
        function: (function_identifier) @function
        (arguments
         [(identifier) @parameter
          (binary_op
           left: (identifier) @parameter)]))
       (identifier) @function
       (binary_op
        left:
        [(call
          function: (function_identifier) @function
          (arguments
           [(identifier) @parameter
            (binary_op
             left: (identifier) @parameter)]))
         (identifier) @function]
        operator: "when")
       (binary_op
        left: (identifier)
        operator: _ @function
        right: (identifier))]
      (#lua-match? @keyword.function "^def%a*$"))

((identifier) @comment
 (#lua-match? @comment "^_[%a%d_]*$"))

((identifier) @constant.builtin
 (#lua-match? @constant.builtin "^__[%a%d_]+__$"))

(ERROR) @error
