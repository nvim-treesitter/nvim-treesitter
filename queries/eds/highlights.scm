"=" @punctuation.delimiter

[ "[" "]" ] @punctuation.bracket

((section_name) @variable.builtin
 (#match? @variable.builtin "\\c^(FileInfo|DeviceInfo|DummyUsage|MandatoryObjects|OptionalObjects)$"))

((section_name) @variable.builtin
 (#lua-match? @variable.builtin "^1"))

(section
   (section_name) @_name
   (#match? @_name "\\c^Comments$")) @comment

(section
   (section_name) @_name
   (statement (key) @_key) @string
   (#match? @_key "\\c^ParameterName$")
   (#not-match? @_name "\\c^Comments$"))

(section
   (section_name) @_name
   (statement (key) @_key) @type
   (#match? @_key "\\c^ObjectType$")
   (#not-match? @_name "\\c^Comments$"))

(section
   (section_name) @_name
   (statement (key) @_key) @type
   (#match? @_key "\\c^DataType$")
   (#not-match? @_name "\\c^Comments$"))

(section
   (section_name) @_name
   (statement (key) @_key) @type.qualifier
   (#match? @_key "\\c^AccessType$")
   (#not-match? @_name "\\c^Comments$"))

(section
   (section_name) @_name
   (statement (key) @_key) @attribute
   (#match? @_key "\\c^PDOMapping$")
   (#not-match? @_name "\\c^Comments$"))

(section
   (section_name) @_name
   (statement (key) @_key) @number
   (#match? @_key "\\c^(DefaultValue|LowLimit|HighLimit|SubNumber)$")
   (#not-match? @_name "\\c^Comments$"))
