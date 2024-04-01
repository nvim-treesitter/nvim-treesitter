; The intention here is to rely on Neovims `autoindent` setting.
; This allows us to not indent after just a single list item
; so we can create narrow lists quickly, but indent blocks inside list items
; to the previous paragraph.
(list_item_content) @indent.auto

(footnote_content) @indent.align

((table_caption) @indent.begin
  (#set! indent.immediate 1))
