(byte) @constant

[
  (hexadecimal)
  (integer)
  (address)
] @number

[
  "file" "format"
  "File" "Offset:"
  "discriminator"
] @text
"Disassembly of section " @text.title

(section_address) @number @text.underline

(identifier) @variable
(code_location (identifier) @function.call)
(header (identifier) @keyword)
(disassembly_section_label (identifier) @namespace)
(disassembly_section (identifier) @namespace)

[(file_offset) (discriminator)] @field

(file_path) @string
(instruction) @function
(bad_instruction) @text.warning
(label) @label

["<" ">"] @punctuation.special
["(" ")"] @punctuation.bracket
["+" ":"] @punctuation.delimiter

(comment) @comment.documentation
