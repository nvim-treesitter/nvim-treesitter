; inherits: cpp

[ "<<<" ">>>" ] @punctuation.bracket

[
  "__host__"
  "__device__"
  "__global__"
  "__forceinline__"
  "__noinline__"
] @storageclass

"__launch_bounds__" @type.qualifier

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
