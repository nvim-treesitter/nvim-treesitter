((paragraph) @injection.content
  (#set! injection.include-children)
  (#set! injection.language "asciidoc_inline"))

((line) @injection.content
  (#set! injection.include-children)
  (#set! injection.language "asciidoc_inline"))

((section_block
  (element_attr
    (element_attr_marker)
    (attr_value) @injection.language
    (element_attr_marker))
  (listing_block
    (listing_block_marker)
    (listing_block_body) @injection.content
    (listing_block_marker)))
  (#gsub! @injection.language "^[^,]*,%s*(%w+)" "%1")
  (#lua-match? @injection.language "^[^,]*,%s*%w+"))

((section_block
  (element_attr
    (element_attr_marker)
    (attr_value) @injection.language
    (element_attr_marker))
  (listing_block
    (listing_block_marker)
    (listing_block_body) @injection.content
    (listing_block_marker)))
  (#any-of? @injection.language
    "a2s" "barcode" "blockdiag" "bpmn" "bytefield" "d2" "dbml" "diagrams" "ditaa" "dpic" "erd"
    "gnuplot" "graphviz" "lilypond" "meme" "mermaid" "msc" "nomnoml" "pikchr" "plantuml" "shaape"
    "smcat" "structurizr" "svgbob" "symbolator" "syntrax" "tikz" "umlet" "vega" "wavedrom"))

((section_block
  (element_attr
    (element_attr_marker)
    (attr_value) @injection.language
    (element_attr_marker))
  (paragraph) @injection.content)
  (#set! injection.include-children)
  (#gsub! @injection.language "^[^,]*,%s*(%w+)" "%1")
  (#lua-match? @injection.language "^[^,]*,%s*%w+"))
