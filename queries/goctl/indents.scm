[
  (importGroup)
  (typeGroupSpec)
  (structType)
  (infoStatement)
  (serviceServerSpec)
  (serviceSpec)
] @indent.begin

(importGroup
  ")" @indent.branch)

(structType
  "}" @indent.branch)

(typeGroupSpec
  ")" @indent.branch)

(infoStatement
  ")" @indent.branch)

(serviceServerSpec
  ")" @indent.branch)

(serviceSpec
  "}" @indent.branch)

[
  "}"
  ")"
] @indent.end

(comment) @indent.ignore

