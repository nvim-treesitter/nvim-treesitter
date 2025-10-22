; =============================================================================
; Tree-sitter Indents for DAE
; =============================================================================

["{"] @indent.begin
["["] @indent.begin
["("] @indent.begin

["}"] @indent.end
["]"] @indent.end
[")"] @indent.end

(comment) @indent.ignore
