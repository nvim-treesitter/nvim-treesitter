; XML declaration
(XMLDecl
  "xml" @keyword.directive)

(XMLDecl
  [
    "version"
    "encoding"
  ] @tag.attribute)

(XMLDecl
  (EncName) @string.special)

(XMLDecl
  (VersionNum) @number)

; Processing instructions
(PI) @keyword.directive

; Element declaration
(elementdecl
  "ELEMENT" @keyword.directive.define
  (Name) @tag)

(contentspec
  (_
    (Name) @tag.attribute))

"#PCDATA" @type.builtin

[
  "EMPTY"
  "ANY"
] @keyword.modifier

[
  "*"
  "?"
  "+"
] @character.special

; Entity declaration
(GEDecl
  "ENTITY" @keyword.directive.define
  (Name) @constant)

(GEDecl
  (EntityValue) @string)

(NDataDecl
  "NDATA" @keyword
  (Name) @label)

; Parsed entity declaration
(PEDecl
  "ENTITY" @keyword.directive.define
  "%" @operator
  (Name) @function.macro)

(PEDecl
  (EntityValue) @string)

; Notation declaration
(NotationDecl
  "NOTATION" @keyword.directive
  (Name) @label)

(NotationDecl
  (ExternalID
    (SystemLiteral
      (URI) @string.special.url))
  (#set! "priority" 105))

; Attlist declaration
(AttlistDecl
  "ATTLIST" @keyword.directive.define
  (Name) @tag)

(AttDef
  (Name) @tag.attribute)

(AttDef
  (Enumeration
    (Nmtoken) @string))

[
  (StringType)
  (TokenizedType)
] @type.builtin

(NotationType
  "NOTATION" @type.builtin)

[
  "#REQUIRED"
  "#IMPLIED"
  "#FIXED"
] @attribute

; Entities
(EntityRef) @constant

((EntityRef) @constant.builtin
  (#any-of? @constant.builtin "&amp;" "&lt;" "&gt;" "&quot;" "&apos;"))

(CharRef) @character

(PEReference) @function.macro

; External references
[
  "PUBLIC"
  "SYSTEM"
] @keyword

(PubidLiteral) @string.special

(SystemLiteral
  (URI) @string.special.url)

; Delimiters & punctuation
[
  "<?"
  "?>"
  "<!"
  ">"
  "]]>"
] @tag.delimiter

[
  "("
  ")"
  "["
] @punctuation.bracket

[
  "\""
  "'"
] @punctuation.delimiter

[
  ","
  "|"
  "="
] @operator

; Misc
[
  "INCLUDE"
  "IGNORE"
] @keyword.import

(Comment) @comment @spell
