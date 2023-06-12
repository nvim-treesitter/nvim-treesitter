; inherits: dtd

;; XML declaration

(XMLDecl "standalone" @tag.attribute)

(XMLDecl [ "yes" "no" ] @boolean)

;; Processing instructions

(XmlModelPI "xml-model" @preproc)

(StyleSheetPI "xml-stylesheet" @preproc)

(PseudoAtt (Name) @tag.attribute)

(PseudoAtt (PseudoAttValue) @string)

;; Doctype declaration

(doctypedecl "DOCTYPE" @define)

(doctypedecl (Name) @type.definition)

;; Tags

(STag (Name) @tag)

(ETag (Name) @tag)

(EmptyElemTag (Name) @tag)

;; Attributes

(Attribute (Name) @tag.attribute)

(Attribute (AttValue) @string)

;; Text

(CharData) @text @spell

((CDSect
  (CDStart) @text.environment
  (CData) @text.literal
  "]]>" @text.environment)
 (#set! "priority" 105))

;; Delimiters & punctuation

[ "<" "</" "/>" ] @tag.delimiter

"]" @punctuation.bracket
