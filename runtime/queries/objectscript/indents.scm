; Indentation rules for ObjectScript UDL (nvim-treesitter)
; --- Class Definition ---
(class_body
  "{" @indent.begin
  "}" @indent.end)

; --- Block-style commands with braces ---
(command_while
  "{" @indent.begin
  "}" @indent.end)

(command_for
  "{" @indent.begin
  "}" @indent.end)

(command_if
  "{" @indent.begin
  "}" @indent.end)

(elseif_block
  "{" @indent.begin
  "}" @indent.end)

(else_block
  "{" @indent.begin
  "}" @indent.end)

; --- Generic brace and parenthesis handling ---
"{" @indent.begin

"}" @indent.end

("(" @indent.align
  (#set! indent.open_delimiter "(")
  (#set! indent.close_delimiter ")"))
