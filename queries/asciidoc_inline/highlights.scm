[
  (monospace)
  (passthrough)
] @markup.raw

(emphasis) @markup.strong

(ltalic) @markup.italic

(highlight) @markup.italic

[
  (link_url)
  (email)
] @markup.link.url @markup.link

(link_label) @markup.link.label

(auto_link
  "["? @punctuation.bracket
  "]"? @punctuation.bracket)

(intrinsic_attributes) @string.special

(replacement
  "{" @punctuation.bracket
  "}" @punctuation.bracket)

(xref
  "<<" @punctuation.bracket
  ">>" @punctuation.bracket)

(xref
  (reftext) @markup.link @markup.link.url)

(xref
  (id) @markup.link.label)

(anchor
  "[[" @punctuation.bracket
  "]]" @punctuation.bracket)

(anchor
  "," @punctuation.delimiter)

(anchor
  (id) @markup.link.label)

(anchor
  (reftext) @markup.link)

(inline_macro
  [
    "kbd"
    "btn"
    "image"
    "audio"
    "video"
    "icon"
    "pass"
    "link"
    "mailto"
    "menu"
    "stem"
    "latexmath"
    "asciimath"
    "footnote"
    "footnoteref"
    "anchor"
    "xref"
    "ifdef"
    "ifndef"
    "ifeval"
    "endif"
    "a2s"
    "barcode"
    "blockdiag"
    "bpmn"
    "bytefield"
    "d2"
    "dbml"
    "diagrams"
    "ditaa"
    "dpic"
    "erd"
    "gnuplot"
    "graphviz"
    "graphviz"
    "lilypond"
    "meme"
    "mermaid"
    "msc"
    "nomnoml"
    "pikchr"
    "plantuml"
    "shaape"
    "smcat"
    "structurizr"
    "svgbob"
    "symbolator"
    "syntrax"
    "tikz"
    "umlet"
    "vega"
    "wavedrom"
  ] @keyword)

(inline_macro
  ":" @punctuation.delimiter)

(inline_macro
  "[" @punctuation.bracket)

(inline_macro
  "]" @punctuation.bracket)

(inline_macro
  (target) @label)

(inline_macro
  (attr) @attribute)

(escaped_ch) @string.escape

(inline_macro
  [
    "image"
    "audio"
    "video"
    "icon"
    "link"
    "mailto"
    "footnote"
    "footnoteref"
    "xref"
  ]
  (target)? @markup.link @markup.link.url
  (attr)? @label)

(inline_macro
  [
    "stem"
    "latexmath"
    "asciimath"
  ]
  (target)?
  (attr)? @markup.raw)
