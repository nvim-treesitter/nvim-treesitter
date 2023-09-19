; inherits: c

[
  "task"
  "sub"
] @keyword.function

[
  "until"
] @repeat

[
  "acquire"
  "monitor"
  "catch"
  "start"
  "stop"
] @keyword.coroutine

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
