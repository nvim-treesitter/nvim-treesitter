; inherits: gotmpl

; For the reasoning concerning the priorities, see gotmpl highlights.
;
; Builtin functions
(function_call
  function: (identifier) @function.builtin
  (#set! priority 110)
  (#any-of? @function.builtin
    "and" "or" "not" "eq" "ne" "lt" "le" "gt" "ge" "default" "required" "empty" "fail" "coalesce"
    "ternary" "print" "println" "printf" "trim" "trimAll" "trimPrefix" "trimSuffix" "lower" "upper"
    "title" "untitle" "repeat" "substr" "nospace" "trunc" "abbrev" "abbrevboth" "initials"
    "randAlphaNum" "randAlpha" "randNumeric" "randAscii" "wrap" "wrapWith" "contains" "hasPrefix"
    "hasSuffix" "quote" "squote" "cat" "indent" "nindent" "replace" "plural" "snakecase" "camelcase"
    "kebabcase" "swapcase" "shuffle" "toStrings" "toDecimal" "toJson" "mustToJson" "toPrettyJson"
    "mustToPrettyJson" "toRawJson" "mustToRawJson" "fromYaml" "fromJson" "fromJsonArray"
    "fromYamlArray" "toYaml" "regexMatch" "mustRegexMatch" "regexFindAll" "mustRegexFinDall"
    "regexFind" "mustRegexFind" "regexReplaceAll" "mustRegexReplaceAll" "regexReplaceAllLiteral"
    "mustRegexReplaceAllLiteral" "regexSplit" "mustRegexSplit" "sha1sum" "sha256sum" "adler32sum"
    "htpasswd" "derivePassword" "genPrivateKey" "buildCustomCert" "genCA" "genSelfSignedCert"
    "genSignedCert" "encryptAES" "decryptAES" "now" "ago" "date" "dateInZone" "duration"
    "durationRound" "unixEpoch" "dateModify" "mustDateModify" "htmlDate" "htmlDateInZone" "toDate"
    "mustToDate" "dict" "get" "set" "unset" "hasKey" "pluck" "dig" "merge" "mustMerge"
    "mergeOverwrite" "mustMergeOverwrite" "keys" "pick" "omit" "values" "deepCopy" "mustDeepCopy"
    "b64enc" "b64dec" "b32enc" "b32dec" "list" "first" "mustFirst" "rest" "mustRest" "last"
    "mustLast" "initial" "mustInitial" "append" "mustAppend" "prepend" "mustPrepend" "concat"
    "reverse" "mustReverse" "uniq" "mustUniq" "without" "mustWithout" "has" "mustHas" "compact"
    "mustCompact" "index" "slice" "mustSlice" "until" "untilStep" "seq" "add" "add1" "sub" "div"
    "mod" "mul" "max" "min" "len" "addf" "add1f" "subf" "divf" "mulf" "maxf" "minf" "floor" "ceil"
    "round" "getHostByName" "base" "dir" "clean" "ext" "isAbs" "kindOf" "kindIs" "typeOf" "typeIs"
    "typeIsLike" "deepequal" "semver" "semverCompare" "urlParse" "urlJoin" "urlquery" "lookup"
    "include"))

; {{ .Values.test }}
(selector_expression
  operand: (field
    name: (identifier) @constant.builtin
    (#set! priority 110)
    (#any-of? @constant.builtin
      "Values" "Chart" "Release" "Capabilities" "Files" "Subcharts" "Template"))
  (field_identifier))

; {{ $.Values.test }}
(selector_expression
  operand: (variable)
  field: (field_identifier) @constant.builtin
  (#set! priority 110)
  (#any-of? @constant.builtin
    "Values" "Chart" "Release" "Capabilities" "Files" "Subcharts" "Template"))
