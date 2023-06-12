[
  "%ifdef"
  "%ifndef"
  "%ifencoder"
  "%ifnencoder"
  "%ifversion"
  "%else"
  "%endif"
  "%argsof"
  "%include"
] @indent.zero

[
  "if"
  "def"
  "let"
  "for"
  "while"
  "try"
  "{"
  "["
  "("
] @indent.begin

(ERROR
  "def") @indent.begin

(def
  "def_end" @indent.end)

(if
  "if_end" @indent.end)

(block
  "block_end" @indent.end)

(for
  "for_end" @indent.end)

(while
  "while_end" @indent.end)

(try
  "try_end" @indent.end)

[
  "then"
  "do"
  "else"
  "elsif"
  "catch"
] @indent.branch

[
  "def_end"
  "if_end"
  "block_end"
  "for_end"
  "while_end"
  "try_end"
  "}"
  "]"
  ")"
] @indent.branch @indent.end

(comment) @indent.auto
