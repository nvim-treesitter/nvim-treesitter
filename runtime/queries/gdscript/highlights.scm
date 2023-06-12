; Basic
(identifier) @variable

(name) @variable

(type
  (identifier) @type)

(comment) @comment @spell

(string_name) @string

(string) @string

(float) @number.float

(integer) @number

(null) @constant

(setter) @function

(getter) @function

(set_body
  "set" @keyword.function)

(get_body
  "get" @keyword.function)

(static_keyword) @keyword.modifier

(tool_statement) @keyword

(breakpoint_statement) @keyword.debug

(inferred_type) @operator

[
  (true)
  (false)
] @boolean

[
  (get_node)
  (node_path)
] @string.special.url

(class_name_statement
  (name) @type) @keyword

(const_statement
  "const" @keyword.modifier
  (name) @constant)

(expression_statement
  (string) @comment @spell)

; Functions
(constructor_definition
  "_init" @constructor)

(function_definition
  (name) @function)

(parameters
  (identifier) @variable.parameter)

(typed_parameter
  (identifier) @variable.parameter)

(default_parameter
  (identifier) @variable.parameter)

(typed_default_parameter
  (identifier) @variable.parameter)

(call
  (identifier) @function.call)

(call
  (identifier) @keyword.import
  (#any-of? @keyword.import "preload" "load"))

; Properties and Methods
; We'll use @property since that's the term Godot uses.
; But, should (source (variable_statement (name))) be @property, too? Since a
; script file is a class in gdscript.
(class_definition
  (body
    (variable_statement
      (name) @property)))

; Same question but for methods?
(class_definition
  (body
    (function_definition
      (name) @function.method)))

(attribute_call
  (identifier) @function.method.call)

(attribute_subscript
  (identifier) @property)

(attribute
  (_)
  (identifier) @property)

; Identifier naming conventions
; - Make sure the following query is below the attribute queries so that it
;   takes precedence on a `(type (attribute (identifier)))`
((identifier) @type
  (#lua-match? @type "^[A-Z]"))

((identifier) @constant
  (#lua-match? @constant "^[A-Z][A-Z_0-9]*$"))

; Enums
(enumerator
  left: (identifier) @constant)

; Special Builtins
((identifier) @variable.builtin
  (#any-of? @variable.builtin "self" "super"))

(attribute_call
  (identifier) @keyword.operator
  (#eq? @keyword.operator "new"))

; Match Pattern
[
  (underscore)
  (pattern_open_ending)
] @character.special

; Alternations
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  ","
  "."
  ":"
] @punctuation.delimiter

[
  "if"
  "elif"
  "else"
  "match"
] @keyword.conditional

(pattern_guard
  "when" @keyword.conditional)

[
  "for"
  "while"
  "break"
  "continue"
] @keyword.repeat

[
  "~"
  "-"
  "*"
  "/"
  "%"
  "+"
  "-"
  "<<"
  ">>"
  "&"
  "^"
  "|"
  "<"
  ">"
  "=="
  "!="
  ">="
  "<="
  "!"
  "&&"
  "||"
  "="
  "+="
  "-="
  "*="
  "/="
  "%="
  "&="
  "|="
  "->"
] @operator

[
  "and"
  "as"
  "in"
  "is"
  "not"
  "or"
] @keyword.operator

[
  "pass"
  "class_name"
  "extends"
  "signal"
  "var"
  "onready"
  "setget"
  "remote"
  "master"
  "puppet"
  "remotesync"
  "mastersync"
  "puppetsync"
] @keyword

"export" @keyword.import

[
  "enum"
  "class"
] @keyword.type

"func" @keyword.function

"return" @keyword.return

"await" @keyword.coroutine

(call
  (identifier) @keyword.coroutine
  (#eq? @keyword.coroutine "yield"))

; Builtins
; generated from
; - godot commit: fb10e67fef
; - https://github.com/godotengine/godot/blob/fb10e67fef/doc/classes
; - https://github.com/godotengine/godot/blob/fb10e67fef/doc/classes/@GlobalScope.xml
; - https://github.com/godotengine/godot/blob/fb10e67fef/modules/gdscript/doc_classes/@GDScript.xml
; Built-in Annotations
((annotation
  "@" @attribute
  (identifier) @attribute)
  (#any-of? @attribute
    ; from modules/gdscript/doc_classes/@GDScript.xml
    "export" "export_category" "export_color_no_alpha" "export_custom" "export_dir" "export_enum"
    "export_exp_easing" "export_file" "export_flags" "export_flags_2d_navigation"
    "export_flags_2d_physics" "export_flags_2d_render" "export_flags_3d_navigation"
    "export_flags_3d_physics" "export_flags_3d_render" "export_flags_avoidance" "export_global_dir"
    "export_global_file" "export_group" "export_multiline" "export_node_path" "export_placeholder"
    "export_range" "export_storage" "export_subgroup" "icon" "onready" "rpc" "static_unload" "tool"
    "warning_ignore"))

; Builtin Types
((identifier) @type.builtin
  (#any-of? @type.builtin
    ; from doc/classes/*.xml
    "AABB" "Array" "Basis" "Callable" "Color" "Dictionary" "NodePath" "PackedByteArray"
    "PackedColorArray" "PackedFloat32Array" "PackedFloat64Array" "PackedInt32Array"
    "PackedInt64Array" "PackedStringArray" "PackedVector2Array" "PackedVector3Array" "Plane"
    "Projection" "Quaternion" "RID" "Rect2" "Rect2i" "Signal" "String" "StringName" "Transform2D"
    "Transform3D" "Vector2" "Vector2i" "Vector3" "Vector3i" "Vector4" "Vector4i" "bool" "float"
    "int"
    ; from doc/classes/@GlobalScope.xml
    "AudioServer" "CameraServer" "ClassDB" "DisplayServer" "EditorInterface" "Engine"
    "EngineDebugger" "GDExtensionManager" "Geometry2D" "Geometry3D" "GodotSharp" "IP" "Input"
    "InputMap" "JavaClassWrapper" "JavaScriptBridge" "Marshalls" "NavigationMeshGenerator"
    "NavigationServer2D" "NavigationServer3D" "OS" "Performance" "PhysicsServer2D"
    "PhysicsServer2DManager" "PhysicsServer3D" "PhysicsServer3DManager" "ProjectSettings"
    "RenderingServer" "ResourceLoader" "ResourceSaver" "ResourceUID" "TextServerManager" "ThemeDB"
    "Time" "TranslationServer" "WorkerThreadPool" "XRServer"))

; Builtin Funcs
(call
  (identifier) @function.builtin
  (#any-of? @function.builtin
    ; from doc/classes/@GlobalScope.xml
    "abs" "absf" "absi" "acos" "acosh" "angle_difference" "asin" "asinh" "atan" "atan2" "atanh"
    "bezier_derivative" "bezier_interpolate" "bytes_to_var" "bytes_to_var_with_objects" "ceil"
    "ceilf" "ceili" "clamp" "clampf" "clampi" "cos" "cosh" "cubic_interpolate"
    "cubic_interpolate_angle" "cubic_interpolate_angle_in_time" "cubic_interpolate_in_time"
    "db_to_linear" "deg_to_rad" "ease" "error_string" "exp" "floor" "floorf" "floori" "fmod"
    "fposmod" "hash" "instance_from_id" "inverse_lerp" "is_equal_approx" "is_finite" "is_inf"
    "is_instance_id_valid" "is_instance_valid" "is_nan" "is_same" "is_zero_approx" "lerp"
    "lerp_angle" "lerpf" "linear_to_db" "log" "max" "maxf" "maxi" "min" "minf" "mini" "move_toward"
    "nearest_po2" "pingpong" "posmod" "pow" "print" "print_rich" "print_verbose" "printerr"
    "printraw" "prints" "printt" "push_error" "push_warning" "rad_to_deg" "rand_from_seed" "randf"
    "randf_range" "randfn" "randi" "randi_range" "randomize" "remap" "rid_allocate_id"
    "rid_from_int64" "rotate_toward" "round" "roundf" "roundi" "seed" "sign" "signf" "signi" "sin"
    "sinh" "smoothstep" "snapped" "snappedf" "snappedi" "sqrt" "step_decimals" "str" "str_to_var"
    "tan" "tanh" "type_convert" "type_string" "typeof" "var_to_bytes" "var_to_bytes_with_objects"
    "var_to_str" "weakref" "wrap" "wrapf" "wrapi"
    ; from modules/gdscript/doc_classes/@GDScript.xml
    "Color8" "assert" "char" "convert" "dict_to_inst" "get_stack" "inst_to_dict" "is_instance_of"
    "len" "load" "preload" "print_debug" "print_stack" "range" "type_exists"))

; Builtin Constants
((identifier) @constant.builtin
  (#any-of? @constant.builtin
    ; from modules/gdscript/doc_classes/@GDScript.xml
    "INF" "NAN" "PI" "TAU"
    ; from doc/classes/@GlobalScope.xml
    "CLOCKWISE" "CORNER_BOTTOM_LEFT" "CORNER_BOTTOM_RIGHT" "CORNER_TOP_LEFT" "CORNER_TOP_RIGHT"
    "COUNTERCLOCKWISE" "ERR_ALREADY_EXISTS" "ERR_ALREADY_IN_USE" "ERR_BUG" "ERR_BUSY"
    "ERR_CANT_ACQUIRE_RESOURCE" "ERR_CANT_CONNECT" "ERR_CANT_CREATE" "ERR_CANT_FORK" "ERR_CANT_OPEN"
    "ERR_CANT_RESOLVE" "ERR_COMPILATION_FAILED" "ERR_CONNECTION_ERROR" "ERR_CYCLIC_LINK"
    "ERR_DATABASE_CANT_READ" "ERR_DATABASE_CANT_WRITE" "ERR_DOES_NOT_EXIST" "ERR_DUPLICATE_SYMBOL"
    "ERR_FILE_ALREADY_IN_USE" "ERR_FILE_BAD_DRIVE" "ERR_FILE_BAD_PATH" "ERR_FILE_CANT_OPEN"
    "ERR_FILE_CANT_READ" "ERR_FILE_CANT_WRITE" "ERR_FILE_CORRUPT" "ERR_FILE_EOF"
    "ERR_FILE_MISSING_DEPENDENCIES" "ERR_FILE_NOT_FOUND" "ERR_FILE_NO_PERMISSION"
    "ERR_FILE_UNRECOGNIZED" "ERR_HELP" "ERR_INVALID_DATA" "ERR_INVALID_DECLARATION"
    "ERR_INVALID_PARAMETER" "ERR_LINK_FAILED" "ERR_LOCKED" "ERR_METHOD_NOT_FOUND"
    "ERR_OUT_OF_MEMORY" "ERR_PARAMETER_RANGE_ERROR" "ERR_PARSE_ERROR" "ERR_PRINTER_ON_FIRE"
    "ERR_QUERY_FAILED" "ERR_SCRIPT_FAILED" "ERR_SKIP" "ERR_TIMEOUT" "ERR_UNAUTHORIZED"
    "ERR_UNAVAILABLE" "ERR_UNCONFIGURED" "EULER_ORDER_XYZ" "EULER_ORDER_XZY" "EULER_ORDER_YXZ"
    "EULER_ORDER_YZX" "EULER_ORDER_ZXY" "EULER_ORDER_ZYX" "FAILED" "HORIZONTAL"
    "HORIZONTAL_ALIGNMENT_CENTER" "HORIZONTAL_ALIGNMENT_FILL" "HORIZONTAL_ALIGNMENT_LEFT"
    "HORIZONTAL_ALIGNMENT_RIGHT" "INLINE_ALIGNMENT_BASELINE_TO" "INLINE_ALIGNMENT_BOTTOM"
    "INLINE_ALIGNMENT_BOTTOM_TO" "INLINE_ALIGNMENT_CENTER" "INLINE_ALIGNMENT_CENTER_TO"
    "INLINE_ALIGNMENT_IMAGE_MASK" "INLINE_ALIGNMENT_TEXT_MASK" "INLINE_ALIGNMENT_TOP"
    "INLINE_ALIGNMENT_TOP_TO" "INLINE_ALIGNMENT_TO_BASELINE" "INLINE_ALIGNMENT_TO_BOTTOM"
    "INLINE_ALIGNMENT_TO_CENTER" "INLINE_ALIGNMENT_TO_TOP" "JOY_AXIS_INVALID" "JOY_AXIS_LEFT_X"
    "JOY_AXIS_LEFT_Y" "JOY_AXIS_MAX" "JOY_AXIS_RIGHT_X" "JOY_AXIS_RIGHT_Y" "JOY_AXIS_SDL_MAX"
    "JOY_AXIS_TRIGGER_LEFT" "JOY_AXIS_TRIGGER_RIGHT" "JOY_BUTTON_A" "JOY_BUTTON_B" "JOY_BUTTON_BACK"
    "JOY_BUTTON_DPAD_DOWN" "JOY_BUTTON_DPAD_LEFT" "JOY_BUTTON_DPAD_RIGHT" "JOY_BUTTON_DPAD_UP"
    "JOY_BUTTON_GUIDE" "JOY_BUTTON_INVALID" "JOY_BUTTON_LEFT_SHOULDER" "JOY_BUTTON_LEFT_STICK"
    "JOY_BUTTON_MAX" "JOY_BUTTON_MISC1" "JOY_BUTTON_PADDLE1" "JOY_BUTTON_PADDLE2"
    "JOY_BUTTON_PADDLE3" "JOY_BUTTON_PADDLE4" "JOY_BUTTON_RIGHT_SHOULDER" "JOY_BUTTON_RIGHT_STICK"
    "JOY_BUTTON_SDL_MAX" "JOY_BUTTON_START" "JOY_BUTTON_TOUCHPAD" "JOY_BUTTON_X" "JOY_BUTTON_Y"
    "KEY_0" "KEY_1" "KEY_2" "KEY_3" "KEY_4" "KEY_5" "KEY_6" "KEY_7" "KEY_8" "KEY_9" "KEY_A"
    "KEY_ALT" "KEY_AMPERSAND" "KEY_APOSTROPHE" "KEY_ASCIICIRCUM" "KEY_ASCIITILDE" "KEY_ASTERISK"
    "KEY_AT" "KEY_B" "KEY_BACK" "KEY_BACKSLASH" "KEY_BACKSPACE" "KEY_BACKTAB" "KEY_BAR"
    "KEY_BRACELEFT" "KEY_BRACERIGHT" "KEY_BRACKETLEFT" "KEY_BRACKETRIGHT" "KEY_C" "KEY_CAPSLOCK"
    "KEY_CLEAR" "KEY_CODE_MASK" "KEY_COLON" "KEY_COMMA" "KEY_CTRL" "KEY_D" "KEY_DELETE" "KEY_DOLLAR"
    "KEY_DOWN" "KEY_E" "KEY_END" "KEY_ENTER" "KEY_EQUAL" "KEY_ESCAPE" "KEY_EXCLAM" "KEY_F" "KEY_F1"
    "KEY_F10" "KEY_F11" "KEY_F12" "KEY_F13" "KEY_F14" "KEY_F15" "KEY_F16" "KEY_F17" "KEY_F18"
    "KEY_F19" "KEY_F2" "KEY_F20" "KEY_F21" "KEY_F22" "KEY_F23" "KEY_F24" "KEY_F25" "KEY_F26"
    "KEY_F27" "KEY_F28" "KEY_F29" "KEY_F3" "KEY_F30" "KEY_F31" "KEY_F32" "KEY_F33" "KEY_F34"
    "KEY_F35" "KEY_F4" "KEY_F5" "KEY_F6" "KEY_F7" "KEY_F8" "KEY_F9" "KEY_FAVORITES" "KEY_FORWARD"
    "KEY_G" "KEY_GLOBE" "KEY_GREATER" "KEY_H" "KEY_HELP" "KEY_HOME" "KEY_HOMEPAGE" "KEY_HYPER"
    "KEY_I" "KEY_INSERT" "KEY_J" "KEY_JIS_EISU" "KEY_JIS_KANA" "KEY_K" "KEY_KEYBOARD" "KEY_KP_0"
    "KEY_KP_1" "KEY_KP_2" "KEY_KP_3" "KEY_KP_4" "KEY_KP_5" "KEY_KP_6" "KEY_KP_7" "KEY_KP_8"
    "KEY_KP_9" "KEY_KP_ADD" "KEY_KP_DIVIDE" "KEY_KP_ENTER" "KEY_KP_MULTIPLY" "KEY_KP_PERIOD"
    "KEY_KP_SUBTRACT" "KEY_L" "KEY_LAUNCH0" "KEY_LAUNCH1" "KEY_LAUNCH2" "KEY_LAUNCH3" "KEY_LAUNCH4"
    "KEY_LAUNCH5" "KEY_LAUNCH6" "KEY_LAUNCH7" "KEY_LAUNCH8" "KEY_LAUNCH9" "KEY_LAUNCHA"
    "KEY_LAUNCHB" "KEY_LAUNCHC" "KEY_LAUNCHD" "KEY_LAUNCHE" "KEY_LAUNCHF" "KEY_LAUNCHMAIL"
    "KEY_LAUNCHMEDIA" "KEY_LEFT" "KEY_LESS" "KEY_LOCATION_LEFT" "KEY_LOCATION_RIGHT"
    "KEY_LOCATION_UNSPECIFIED" "KEY_M" "KEY_MASK_ALT" "KEY_MASK_CMD_OR_CTRL" "KEY_MASK_CTRL"
    "KEY_MASK_GROUP_SWITCH" "KEY_MASK_KPAD" "KEY_MASK_META" "KEY_MASK_SHIFT" "KEY_MEDIANEXT"
    "KEY_MEDIAPLAY" "KEY_MEDIAPREVIOUS" "KEY_MEDIARECORD" "KEY_MEDIASTOP" "KEY_MENU" "KEY_META"
    "KEY_MINUS" "KEY_MODIFIER_MASK" "KEY_N" "KEY_NONE" "KEY_NUMBERSIGN" "KEY_NUMLOCK" "KEY_O"
    "KEY_OPENURL" "KEY_P" "KEY_PAGEDOWN" "KEY_PAGEUP" "KEY_PARENLEFT" "KEY_PARENRIGHT" "KEY_PAUSE"
    "KEY_PERCENT" "KEY_PERIOD" "KEY_PLUS" "KEY_PRINT" "KEY_Q" "KEY_QUESTION" "KEY_QUOTEDBL"
    "KEY_QUOTELEFT" "KEY_R" "KEY_REFRESH" "KEY_RIGHT" "KEY_S" "KEY_SCROLLLOCK" "KEY_SEARCH"
    "KEY_SECTION" "KEY_SEMICOLON" "KEY_SHIFT" "KEY_SLASH" "KEY_SPACE" "KEY_SPECIAL" "KEY_STANDBY"
    "KEY_STOP" "KEY_SYSREQ" "KEY_T" "KEY_TAB" "KEY_U" "KEY_UNDERSCORE" "KEY_UNKNOWN" "KEY_UP"
    "KEY_V" "KEY_VOLUMEDOWN" "KEY_VOLUMEMUTE" "KEY_VOLUMEUP" "KEY_W" "KEY_X" "KEY_Y" "KEY_YEN"
    "KEY_Z" "METHOD_FLAGS_DEFAULT" "METHOD_FLAG_CONST" "METHOD_FLAG_EDITOR" "METHOD_FLAG_NORMAL"
    "METHOD_FLAG_OBJECT_CORE" "METHOD_FLAG_STATIC" "METHOD_FLAG_VARARG" "METHOD_FLAG_VIRTUAL"
    "MIDI_MESSAGE_ACTIVE_SENSING" "MIDI_MESSAGE_AFTERTOUCH" "MIDI_MESSAGE_CHANNEL_PRESSURE"
    "MIDI_MESSAGE_CONTINUE" "MIDI_MESSAGE_CONTROL_CHANGE" "MIDI_MESSAGE_NONE"
    "MIDI_MESSAGE_NOTE_OFF" "MIDI_MESSAGE_NOTE_ON" "MIDI_MESSAGE_PITCH_BEND"
    "MIDI_MESSAGE_PROGRAM_CHANGE" "MIDI_MESSAGE_QUARTER_FRAME" "MIDI_MESSAGE_SONG_POSITION_POINTER"
    "MIDI_MESSAGE_SONG_SELECT" "MIDI_MESSAGE_START" "MIDI_MESSAGE_STOP"
    "MIDI_MESSAGE_SYSTEM_EXCLUSIVE" "MIDI_MESSAGE_SYSTEM_RESET" "MIDI_MESSAGE_TIMING_CLOCK"
    "MIDI_MESSAGE_TUNE_REQUEST" "MOUSE_BUTTON_LEFT" "MOUSE_BUTTON_MASK_LEFT"
    "MOUSE_BUTTON_MASK_MB_XBUTTON1" "MOUSE_BUTTON_MASK_MB_XBUTTON2" "MOUSE_BUTTON_MASK_MIDDLE"
    "MOUSE_BUTTON_MASK_RIGHT" "MOUSE_BUTTON_MIDDLE" "MOUSE_BUTTON_NONE" "MOUSE_BUTTON_RIGHT"
    "MOUSE_BUTTON_WHEEL_DOWN" "MOUSE_BUTTON_WHEEL_LEFT" "MOUSE_BUTTON_WHEEL_RIGHT"
    "MOUSE_BUTTON_WHEEL_UP" "MOUSE_BUTTON_XBUTTON1" "MOUSE_BUTTON_XBUTTON2" "OK" "OP_ADD" "OP_AND"
    "OP_BIT_AND" "OP_BIT_NEGATE" "OP_BIT_OR" "OP_BIT_XOR" "OP_DIVIDE" "OP_EQUAL" "OP_GREATER"
    "OP_GREATER_EQUAL" "OP_IN" "OP_LESS" "OP_LESS_EQUAL" "OP_MAX" "OP_MODULE" "OP_MULTIPLY"
    "OP_NEGATE" "OP_NOT" "OP_NOT_EQUAL" "OP_OR" "OP_POSITIVE" "OP_POWER" "OP_SHIFT_LEFT"
    "OP_SHIFT_RIGHT" "OP_SUBTRACT" "OP_XOR" "PROPERTY_HINT_ARRAY_TYPE"
    "PROPERTY_HINT_COLOR_NO_ALPHA" "PROPERTY_HINT_DIR" "PROPERTY_HINT_ENUM"
    "PROPERTY_HINT_ENUM_SUGGESTION" "PROPERTY_HINT_EXPRESSION" "PROPERTY_HINT_EXP_EASING"
    "PROPERTY_HINT_FILE" "PROPERTY_HINT_FLAGS" "PROPERTY_HINT_GLOBAL_DIR"
    "PROPERTY_HINT_GLOBAL_FILE" "PROPERTY_HINT_GLOBAL_SAVE_FILE"
    "PROPERTY_HINT_HIDE_QUATERNION_EDIT" "PROPERTY_HINT_INT_IS_OBJECTID"
    "PROPERTY_HINT_INT_IS_POINTER" "PROPERTY_HINT_LAYERS_2D_NAVIGATION"
    "PROPERTY_HINT_LAYERS_2D_PHYSICS" "PROPERTY_HINT_LAYERS_2D_RENDER"
    "PROPERTY_HINT_LAYERS_3D_NAVIGATION" "PROPERTY_HINT_LAYERS_3D_PHYSICS"
    "PROPERTY_HINT_LAYERS_3D_RENDER" "PROPERTY_HINT_LAYERS_AVOIDANCE" "PROPERTY_HINT_LINK"
    "PROPERTY_HINT_LOCALE_ID" "PROPERTY_HINT_LOCALIZABLE_STRING" "PROPERTY_HINT_MAX"
    "PROPERTY_HINT_MULTILINE_TEXT" "PROPERTY_HINT_NODE_PATH_TO_EDITED_NODE"
    "PROPERTY_HINT_NODE_PATH_VALID_TYPES" "PROPERTY_HINT_NODE_TYPE" "PROPERTY_HINT_NONE"
    "PROPERTY_HINT_OBJECT_ID" "PROPERTY_HINT_OBJECT_TOO_BIG" "PROPERTY_HINT_PASSWORD"
    "PROPERTY_HINT_PLACEHOLDER_TEXT" "PROPERTY_HINT_RANGE" "PROPERTY_HINT_RESOURCE_TYPE"
    "PROPERTY_HINT_SAVE_FILE" "PROPERTY_HINT_TYPE_STRING" "PROPERTY_USAGE_ALWAYS_DUPLICATE"
    "PROPERTY_USAGE_ARRAY" "PROPERTY_USAGE_CATEGORY" "PROPERTY_USAGE_CHECKABLE"
    "PROPERTY_USAGE_CHECKED" "PROPERTY_USAGE_CLASS_IS_BITFIELD" "PROPERTY_USAGE_CLASS_IS_ENUM"
    "PROPERTY_USAGE_DEFAULT" "PROPERTY_USAGE_DEFERRED_SET_RESOURCE" "PROPERTY_USAGE_EDITOR"
    "PROPERTY_USAGE_EDITOR_BASIC_SETTING" "PROPERTY_USAGE_EDITOR_INSTANTIATE_OBJECT"
    "PROPERTY_USAGE_GROUP" "PROPERTY_USAGE_HIGH_END_GFX" "PROPERTY_USAGE_INTERNAL"
    "PROPERTY_USAGE_KEYING_INCREMENTS" "PROPERTY_USAGE_NEVER_DUPLICATE"
    "PROPERTY_USAGE_NIL_IS_VARIANT" "PROPERTY_USAGE_NODE_PATH_FROM_SCENE_ROOT" "PROPERTY_USAGE_NONE"
    "PROPERTY_USAGE_NO_EDITOR" "PROPERTY_USAGE_NO_INSTANCE_STATE" "PROPERTY_USAGE_READ_ONLY"
    "PROPERTY_USAGE_RESOURCE_NOT_PERSISTENT" "PROPERTY_USAGE_RESTART_IF_CHANGED"
    "PROPERTY_USAGE_SCRIPT_DEFAULT_VALUE" "PROPERTY_USAGE_SCRIPT_VARIABLE" "PROPERTY_USAGE_SECRET"
    "PROPERTY_USAGE_STORAGE" "PROPERTY_USAGE_STORE_IF_NULL" "PROPERTY_USAGE_SUBGROUP"
    "PROPERTY_USAGE_UPDATE_ALL_IF_MODIFIED" "SIDE_BOTTOM" "SIDE_LEFT" "SIDE_RIGHT" "SIDE_TOP"
    "TYPE_AABB" "TYPE_ARRAY" "TYPE_BASIS" "TYPE_BOOL" "TYPE_CALLABLE" "TYPE_COLOR" "TYPE_DICTIONARY"
    "TYPE_FLOAT" "TYPE_INT" "TYPE_MAX" "TYPE_NIL" "TYPE_NODE_PATH" "TYPE_OBJECT"
    "TYPE_PACKED_BYTE_ARRAY" "TYPE_PACKED_COLOR_ARRAY" "TYPE_PACKED_FLOAT32_ARRAY"
    "TYPE_PACKED_FLOAT64_ARRAY" "TYPE_PACKED_INT32_ARRAY" "TYPE_PACKED_INT64_ARRAY"
    "TYPE_PACKED_STRING_ARRAY" "TYPE_PACKED_VECTOR2_ARRAY" "TYPE_PACKED_VECTOR3_ARRAY" "TYPE_PLANE"
    "TYPE_PROJECTION" "TYPE_QUATERNION" "TYPE_RECT2" "TYPE_RECT2I" "TYPE_RID" "TYPE_SIGNAL"
    "TYPE_STRING" "TYPE_STRING_NAME" "TYPE_TRANSFORM2D" "TYPE_TRANSFORM3D" "TYPE_VECTOR2"
    "TYPE_VECTOR2I" "TYPE_VECTOR3" "TYPE_VECTOR3I" "TYPE_VECTOR4" "TYPE_VECTOR4I" "VERTICAL"
    "VERTICAL_ALIGNMENT_BOTTOM" "VERTICAL_ALIGNMENT_CENTER" "VERTICAL_ALIGNMENT_FILL"
    "VERTICAL_ALIGNMENT_TOP"))
