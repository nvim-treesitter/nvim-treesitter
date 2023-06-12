;; XML declaration

(XMLDecl "xml" @preproc)

(XMLDecl [ "version" "encoding" ] @tag.attribute)

(XMLDecl (EncName) @string.special)

(XMLDecl (VersionNum) @number)

;; Processing instructions

(PI) @preproc

;; Element declaration

(elementdecl
  "ELEMENT" @define
  (Name) @tag)

(contentspec
  (_ (Name) @tag.attribute))

"#PCDATA" @type.builtin

[ "EMPTY" "ANY" ] @type.qualifier

[ "*" "?" "+" ] @character.special

;; Entity declaration

(GEDecl
  "ENTITY" @define
  (Name) @constant)

(GEDecl (EntityValue) @string)

(NDataDecl
  "NDATA" @keyword
  (Name) @label)

;; Parsed entity declaration

(PEDecl
  "ENTITY" @define
  "%" @operator
  (Name) @function.macro)

(PEDecl (EntityValue) @string)

;; Notation declaration

(NotationDecl
  "NOTATION" @preproc
  (Name) @label)

((NotationDecl
  (ExternalID
    (SystemLiteral (URI) @string.special))
 (#set! "priority" 105)))

;; Attlist declaration

(AttlistDecl
  "ATTLIST" @define
  (Name) @tag)

(AttDef (Name) @tag.attribute)

(AttDef (Enumeration (Nmtoken) @string))

[
  (StringType)
  (TokenizedType)
] @type.builtin

(NotationType "NOTATION" @type.builtin)

[
  "#REQUIRED"
  "#IMPLIED"
  "#FIXED"
] @attribute

;; Entities

(EntityRef) @constant

((EntityRef) @constant.builtin
 (#any-of? @constant.builtin
   "&amp;" "&lt;" "&gt;" "&quot;" "&apos;"))

(CharRef) @character

(PEReference) @function.macro

;; External references

[ "PUBLIC" "SYSTEM" ] @keyword

(PubidLiteral) @string.special

(SystemLiteral (URI) @text.uri)

;; Delimiters & punctuation

[ "<?" "?>" "<!" ">" "]]>" ] @tag.delimiter

[ "(" ")" "[" ] @punctuation.bracket

[ "\"" "'" ] @punctuation.delimiter

[ "," "|" "=" ] @operator

;; Misc

[ "INCLUDE" "IGNORE" ] @include

(Comment) @comment @spell
