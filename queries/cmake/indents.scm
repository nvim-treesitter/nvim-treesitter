[
  (normal_command)
  (if_condition)
  (foreach_loop)
  (while_loop)
  (function_def)
  (macro_def)
  (block_def)
] @indent.begin

[
 (elseif_command)
 (elseif_command)
 (endif_command)
 (endforeach_command)
 (endfunction_command)
 (endmacro_command)
 (endblock_command)
] @indent.branch

(normal_command ")" @indent.branch)
