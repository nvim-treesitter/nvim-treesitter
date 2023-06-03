;; Variables
(identifier) @variable

;; Misc

(comment) @comment @spell

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^///[^/]"))

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^///$"))

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^/[*][*][^*].*[*]/$"))

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^/[+][+][^+].*[+]/$"))

(directive) @preproc
(shebang) @preproc

;; Operators

[
  "/="
  "/"
  ".."
  "..."
  "&"
  "&="
  "&&"
  "|"
  "|="
  "||"
  "-"
  "-="
  "--"
  "+"
  "+="
  "++"
  "<"
  "<="
  "<<"
  "<<="
  ">"
  ">="
  ">>="
  ">>>="
  ">>"
  ">>>"
  "!"
  "!="
  "?"
  "$"
  "="
  "=="
  "*"
  "*="
  "%"
  "%="
  "^"
  "^="
  "^^"
  "^^="
  "~"
  "~="
  "@"
  "=>"
] @operator

;; Punctuation

[
  "(" ")"
  "[" "]"
  "{" "}"
] @punctuation.bracket

[
  ","
  ";"
  "."
  ":"
] @punctuation.delimiter

[
  ".."
  "$"
] @punctuation.special

;; Keywords

; these are listed first, because they override keyword queries
(identity_expression (in) @keyword.operator)
(identity_expression (is) @keyword.operator)

[
  (not_in)
  (not_is)
] @keyword.operator

[
  (const)
  (immutable)
  (inout)
  (shared)
] @type.qualifier

[
  (gshared)
  (scope)
  (abstract)
  (final)
  (override)
  (lazy)
  (align)
  (extern)
  (static)
  (synchronized)
  (auto)
  (ref)
  (nothrow)
  (pure)
  (deprecated)
] @storageclass

(parameter_attribute (return) @storageclass)
(parameter_attribute (in) @storageclass)
(parameter_attribute (out) @storageclass)

[
  (case)
  (default)
  (if)
  (else)
  (switch)
] @conditional

[
  (break)
  (continue)
  (do)
  (for)
  (while)
  (foreach)
  (foreach_reverse)
] @repeat

[
  (delegate)
  (function)
] @keyword.function

(return) @keyword.return

(debug) @debug
(import) @include

[
  (abstract)
  (alias)
  (align)
  (asm)
  (assert)
  (cast)
  (class)
  (delete)
  (enum)
  (export)
  (extern)
  (final)
  (in)
  (inout)
  (interface)
  (invariant)
  (is)
  (lazy)
  ; "macro" - obsolete
  (mixin)
  (module)
  (new)
  (nothrow)
  (out)
  (override)
  (package)
  (pragma)
  (private)
  (protected)
  (public)
  (pure)
  (ref)
  (static)
  (struct)
  (super)
  (synchronized)
  (template)
  (this)
  (typeid)
  (typeof)
  (union)
  (unittest)
  (version)
  (with)
  (gshared)
  (traits)
  (vector)
  (parameters_)
] @keyword

[
  (catch)
  (finally)
  (throw)
  (try)
] @exception

(label (identifier) @label)
(goto_statement (goto) @keyword (identifier) @label)

(at_attribute) @attribute

;; Literals

(int_literal) @number
(float_literal) @float
(char_literal) @character
(string_literal) @string

[
  (true)
  (false)
] @boolean

;; Constants

(null) @constant.builtin
(special_keyword) @constant.builtin

;; Types

[
  (void)
  (bool)
  (byte)
  (ubyte)
  (char)
  (short)
  (ushort)
  (wchar)
  (dchar)
  (int)
  (uint)
  (long)
  (ulong)
  (real)
  (double)
  (float)

  ; considered deprecated builtin types
  (cent)
  (ucent)
  (ireal)
  (idouble)
  (ifloat)
  (creal)
  (double)
  (cfloat)
] @type.builtin

(type (identifier) @type)

;; Functions

(function_declaration (identifier) @function)

(call_expression (identifier) @function.call)
(call_expression (type (identifier) @function.call))

; everything after __EOF_ is plain text
(end_file) @text

; special node for errors
(ERROR) @error
