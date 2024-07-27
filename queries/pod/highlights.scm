; A highlight file for nvim-treesitter to use
[
  (pod_command)
  (command)
  (cut_command)
] @keyword

((command_paragraph
  (command) @keyword
  (content) @string)
  (#set! priority 99))

(command_paragraph
  (command) @keyword
  (#lua-match? @keyword "^=head")
  (content) @markup.heading)

(command_paragraph
  (command) @keyword
  (#lua-match? @keyword "^=over")
  (content) @number)

(command_paragraph
  (command) @keyword
  (#lua-match? @keyword "^=item")
  (content) @none)

(command_paragraph
  (command) @keyword
  (#lua-match? @keyword "^=encoding")
  (content) @string.special)

(verbatim_paragraph
  (content) @markup.raw)

(interior_sequence
  (sequence_letter) @character
  [
    "<"
    ">"
  ] @punctuation.delimiter)

(interior_sequence
  (sequence_letter) @character
  (#eq? @character "B")
  (content) @markup.strong)

(interior_sequence
  (sequence_letter) @character
  (#eq? @character "C")
  (content) @markup.raw)

(interior_sequence
  (sequence_letter) @character
  (#eq? @character "F")
  (content) @string.special.path)

(interior_sequence
  (sequence_letter) @character
  (#eq? @character "I")
  (content) @markup.italic)

(interior_sequence
  (sequence_letter) @character
  (#eq? @character "L")
  (content) @string.special.url)

(interior_sequence
  (sequence_letter) @character
  (#eq? @character "X")
  (content) @markup.link)

(interior_sequence
  (sequence_letter) @character
  (#eq? @character "E")
  (content) @string.escape)
