; https://tonsky.me/blog/clojurefmt/

; Align lines within forms
((list_lit)               @indent.align (#set! indent.open_delimiter "(") (#set! indent.close_delimiter ")"))
((vec_lit)                @indent.align (#set! indent.open_delimiter "[") (#set! indent.close_delimiter "]"))
((map_lit)                @indent.align (#set! indent.open_delimiter "{") (#set! indent.close_delimiter "}"))
((set_lit)                @indent.align (#set! indent.open_delimiter "{") (#set! indent.close_delimiter "}"))
((anon_fn_lit)            @indent.align (#set! indent.open_delimiter "(") (#set! indent.close_delimiter ")"))
((read_cond_lit)          @indent.align (#set! indent.open_delimiter "(") (#set! indent.close_delimiter ")"))
((splicing_read_cond_lit) @indent.align (#set! indent.open_delimiter "(") (#set! indent.close_delimiter ")"))

([(map_lit) (set_lit) (vec_lit) (list_lit) (anon_fn_lit) (read_cond_lit) (splicing_read_cond_lit)]
 @indent.align
 ; Align lines even when parent open_delimiter is hanging
 (#set! indent.align_hanging 1)
 ; Allow parent nodes on same line to indent (e.g. '(' and '[' on single line)
 (#set! indent.propagate 1))

; Indent lists starting with a symbol by 2 spaces
([(list_lit    . (sym_lit))
  (anon_fn_lit . (sym_lit))]
 @indent.align 
 (#set! indent.increment 2))

; Indent form on line following #_
((dis_expr) @indent.begin @indent.end)
