; inherits: dtd

; XML declaration
(XMLDecl
  "standalone" @tag.attribute)

(XMLDecl
  [
    "yes"
    "no"
  ] @boolean)

; Processing instructions
(XmlModelPI
  "xml-model" @keyword.directive)

(StyleSheetPI
  "xml-stylesheet" @keyword.directive)

(PseudoAtt
  (Name) @tag.attribute)

(PseudoAtt
  (PseudoAttValue) @string)

; Doctype declaration
(doctypedecl
  "DOCTYPE" @keyword.directive.define)

(doctypedecl
  (Name) @type.definition)

; Tags
(STag
  (Name) @tag)

(ETag
  (Name) @tag)

(EmptyElemTag
  (Name) @tag)

; Attributes
(Attribute
  (Name) @tag.attribute)

(Attribute
  (AttValue) @string)

; Text
(CharData) @none @spell

((CDSect
  (CDStart) @module
  (CData) @markup.raw
  "]]>" @module)
  (#set! "priority" 105))

; Delimiters & punctuation
[
  "<"
  "</"
  "/>"
] @tag.delimiter

"]" @punctuation.bracket
