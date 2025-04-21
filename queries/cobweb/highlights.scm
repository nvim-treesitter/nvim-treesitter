; tree-sitter-cobweb/queries/highlights.scm

; === Comments ===
(line_comment) @comment
(block_comment) @comment

; === Sections ===
(section_header) @keyword.control.import ; #manifest, #import, #defs, #commands, #scenes

; === Keywords ===
(keyword) @keyword ; 'as'

; === Literals ===
(string_literal) @string
(escape_sequence) @string.escape
(line_continuation) @string.escape
(number_literal) @constant.numeric
(hex_literal) @constant.numeric ; Often highlighted like numbers or colors

; === Builtin Constants ===
(language_constant) @constant.builtin ; auto, inf, nan

; === Definitions (#defs section) ===
(definition name: (constant_identifier) @variable.constant)
(definition "=" @operator)

; === Constants Usage ===
(constant_usage "$" @constant) ; Highlight the '$' itself
; Highlight all identifiers within the path field of a constant usage
(constant_usage path: (identifier) @constant)
; The PATH_SEPARATOR is captured globally below

; === Manifest & Import Sections ===
(manifest_entry path: (string_literal) @string.special.path) ; Highlight file paths
(manifest_entry alias: (identifier) @variable.alias)
(import_entry source: (identifier) @variable.module) ; Imported manifest key
(import_entry alias: (identifier) @variable.alias)

; === Scenes Section ===
(scene_definition name: (string_literal) @label) ; Scene names
(named_element name: (string_literal) @label) ; Nested element names like "cell"

; === Loadables & Types ===
; General Types
(type_identifier) @type ; Default for uppercase identifiers

; Specific Loadable Types
(struct_loadable type: (type_identifier) @type)
(tuple_loadable type: (type_identifier) @type)
(simple_loadable type: (type_identifier) @type) ; e.g., MainInterface
(generic_loadable type: (type_identifier) @type) ; e.g., Animated
(generic_loadable generic_type: (type_identifier) @type.generic) ; e.g., BackgroundColor inside <>

; Type Identifiers used as Values (Enum Variants)
((field value: (type_identifier)) @constant.builtin.enum) ; e.g., Column in flex_direction:Column

; === Fields ===
(field name: (identifier) @property) ; Field names like 'color', 'text'
(field ":" @punctuation.delimiter)

; === Punctuation ===
"{" @punctuation.bracket
"}" @punctuation.bracket
"(" @punctuation.bracket
")" @punctuation.bracket
"<" @punctuation.bracket
">" @punctuation.bracket
":" @punctuation.delimiter ; Already captured in field, but maybe useful standalone if it occurs elsewhere
"=" @operator ; Already captured in definition
(PATH_SEPARATOR) @punctuation.delimiter ; Highlight '::' globally using the aliased node name

; === Fallback (Optional) ===
; (identifier) @variable ; Generic lowercase identifiers (might catch aliases/module names if not specifically captured)

; === Errors (Optional but Recommended) ===
; (ERROR) @error
