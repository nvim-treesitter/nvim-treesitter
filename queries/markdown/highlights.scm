;; MarkDown highlighting
(atx_heading) @Constant
(link_text) @String
(link_destination) @Type
(emphasis) @Special
(strong_emphasis) @SpecialComment

(fenced_code_block (info_string) @Type (code_fence_content) @Ignore) @Function
(code_span (text) @Ignore ) @Function
