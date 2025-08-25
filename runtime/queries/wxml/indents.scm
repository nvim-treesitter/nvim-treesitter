; inherits: html_tags

(block_element) @indent.begin

(template_element) @indent.begin

(wxs_element) @indent.begin

(block_element
  (block_end_tag
    ">" @indent.end))

(template_element
  (template_end_tag
    ">" @indent.end))

(wxs_element
  (wxs_end_tag
    ">" @indent.end))

(block_element
  (block_end_tag) @indent.branch)

(template_element
  (template_end_tag) @indent.branch)

(wxs_element
  (wxs_end_tag) @indent.branch)

(import_statement) @indent.ignore

(include_statement) @indent.ignore
