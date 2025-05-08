; https://tonsky.me/blog/clojurefmt/

; Align lines within forms
((list_lit               open: _ @indent.open close: _ @indent.close) @indent.align)
((vec_lit                open: _ @indent.open close: _ @indent.close) @indent.align)
((map_lit                open: _ @indent.open close: _ @indent.close) @indent.align)
((set_lit                open: _ @indent.open close: _ @indent.close) @indent.align)
((anon_fn_lit            open: _ @indent.open close: _ @indent.close) @indent.align)
((read_cond_lit          open: _ @indent.open close: _ @indent.close) @indent.align)
((splicing_read_cond_lit open: _ @indent.open close: _ @indent.close) @indent.align)

([(map_lit) (set_lit) (vec_lit) (list_lit) (anon_fn_lit) (read_cond_lit) (splicing_read_cond_lit)]
 @indent.align
 ; Align lines even when parent open_delimiter is hanging
 (#set! indent.align_hanging 1)
 ; Allow parent nodes on same line to indent (e.g. '(' and '[' on single line)
 (#set! indent.propagate 1))

; Indent lists starting with a symbol by 2 spaces
([(list_lit    ((meta_lit)* . (sym_lit)))
  (anon_fn_lit ((meta_lit)* . (sym_lit)))]
 @indent.align 
 (#set! indent.increment 2))

; Indent form on line following #_
((dis_expr) @indent.begin @indent.end)
