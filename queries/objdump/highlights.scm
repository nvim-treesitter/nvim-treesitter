(byte) @constant

[
  (hexadecimal)
  (integer)
  (address)
] @number

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
(machine_code_bytes) @field

["<" ">"] @punctuation.special
["(" ")"] @punctuation.bracket
["+" ":"] @punctuation.delimiter

(comment) @comment.documentation
