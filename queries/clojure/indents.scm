; https://tonsky.me/blog/clojurefmt/

; Align lines within forms
((list_lit               open: _ @indent.open close: _ @indent.close) @indent.align)
((vec_lit                open: _ @indent.open close: _ @indent.close) @indent.align)
((map_lit                open: _ @indent.open close: _ @indent.close) @indent.align)
((ns_map_lit             open: _ @indent.open close: _ @indent.close) @indent.align)
((set_lit                open: _ @indent.open close: _ @indent.close) @indent.align)
((anon_fn_lit            open: _ @indent.open close: _ @indent.close) @indent.align)
((read_cond_lit          open: _ @indent.open close: _ @indent.close) @indent.align)
((splicing_read_cond_lit open: _ @indent.open close: _ @indent.close) @indent.align)

([(list_lit) (vec_lit) (map_lit) (ns_map_lit) (set_lit) (anon_fn_lit) (read_cond_lit) (splicing_read_cond_lit)]
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

; Indent 1 space for forms: ', `, ~, #, @
([(quoting_lit) (syn_quoting_lit) (unquoting_lit) (tagged_or_ctor_lit) (derefing_lit) ] 
 @indent.begin @indent.end
 (#set! indent.increment 1)
 (#set! indent.propagate 1))

; Indent 2 space for forms: ~@, #', #_, #=, #^, ##
([(unquote_splicing_lit) (var_quoting_lit) (dis_expr) (evaling_lit) (old_meta_lit) (sym_val_lit)]
 @indent.begin @indent.end
 (#set! indent.increment 2)
 (#set! indent.propagate 1))
