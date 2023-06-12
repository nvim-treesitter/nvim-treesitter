;; tags

(elementdecl (Name) @definition.type)

(elementdecl
  (contentspec
    (children (Name) @reference)))

(AttlistDecl . (Name) @reference)

(STag (Name) @reference)
(ETag (Name) @reference)
(EmptyElemTag (Name) @reference)

;; attributes

(AttDef (Name) @definition.field)

(Attribute (Name) @reference)

;; entities

(GEDecl (Name) @definition.macro)

(EntityRef (Name) @reference)
