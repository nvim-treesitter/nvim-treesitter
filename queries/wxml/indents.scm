(start_tag
  ">" @end) @indent

(self_closing_tag
  "/>" @end) @indent

(element
  (start_tag) @start
  (end_tag)? @end) @indent

(block_element
  (block_start_tag) @start
  (block_end_tag)? @end) @indent

(slot_element
  (slot_start_tag) @start
  (slot_end_tag)? @end) @indent

(template_element
  (template_start_tag) @start
  (template_end_tag)? @end) @indent

(wxs_element
  (wxs_start_tag) @start
  (wxs_end_tag)? @end) @indent
