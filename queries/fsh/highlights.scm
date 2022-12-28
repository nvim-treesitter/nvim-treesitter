[
  "("
  ")"
] @punctuation.bracket

[
  "^"
  "="
  ":"
] @punctuation.operator

[
  "#"
  ".."
  "*"
  "->"
] @punctuation.special

; Entity Keywords
[
  "Profile"
  "Alias"
  "Extension"
  "Invariant"
  "Instance"
  "ValueSet"
  "CodeSystem"
  "Mapping"
  "Logical"
  "Resource"
  "RuleSet"
] @keyword

; Metadata Keywords
[
  "Parent"
  "Title"
  "Description"
  "Id"
  "Severity"
  "InstanceOf"
  "Usage"
  "Source"
  "XPath"
  "Target"
] @keyword

; Rule Keywords
[
  "contentReference"
  "insert"
  "and"
  "or"
  "contains"
  "named"
  "only"
  "obeys"
  "valueset"
  "codes"
  "from"
  "include"
  "exclude"
  "where"
  "system"
  "exactly"
] @keyword

; Types
[
  "Reference"
  "Canonical"
] @type


(sd_metadata (parent (name))) @type
(target_type (name)) @type

; Strings
(string) @string @spell
(multiline_string) @string @spell

; Constants
(strength_value) @constant
(bool) @constant.boolean
(flag) @constant

; Special Params
(code_value) @parameter

; Extras
(fsh_comment) @comment @spell
