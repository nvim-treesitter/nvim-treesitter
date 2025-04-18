[
  (braced_word_simple)
  (namespace)
  (command)
  (if)
  (else)
  (elseif)
  (foreach)
  (while)
  (try)
  (procedure)
  (command_substitution)
] @indent.begin

(quoted_word) @indent.align

([
  (expr)
  (arguments)
] @indent.align
  (#set! indent.open_delimiter "{")
  (#set! indent.close_delimiter "}"))

[
  "}"
  "]"
] @indent.branch @indent.end
