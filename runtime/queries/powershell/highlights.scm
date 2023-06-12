; Punctuation
;------------
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

(hash_literal_expression
  [
    "@{"
    "}"
  ] @punctuation.special)

(array_expression
  [
    "@("
    ")"
  ] @punctuation.special)

[
  "."
  "::"
  ","
  ";"
  (empty_statement)
  (command_argument_sep)
] @punctuation.delimiter

; Keywords
;---------
[
  "if"
  "elseif"
  "else"
  "switch"
] @keyword.conditional

[
  "foreach"
  "for"
  "while"
  "do"
  "until"
  "in"
  "break"
  "continue"
] @keyword.repeat

[
  "function"
  "filter"
  "workflow"
  "exit"
  "trap"
  "param"
  "inlinescript"
] @keyword.function

"return" @keyword.return

[
  "class"
  "enum"
] @keyword.type

[
  "data"
  (class_attribute)
] @keyword.modifier

[
  "throw"
  "try"
  "catch"
  "finally"
] @keyword.exception

[
  "parallel"
  "sequence"
] @keyword.coroutine

[
  "param"
  "dynamicparam"
  "begin"
  "process"
  "end"
] @keyword

; Operators
;----------
[
  "-and"
  "-or"
  "-xor"
  "-band"
  "-bor"
  "-bxor"
  "+"
  "-"
  "/"
  "\\"
  "%"
  "*"
  ".."
  "-not"
  "-bnot"
  "!"
  "="
  "|"
  (pre_increment_expression)
  (pre_decrement_expression)
  (post_increment_expression)
  (post_decrement_expression)
  (comparison_operator)
  (assignement_operator)
] @operator

; Generic types
;--------------
(string_literal) @string

(integer_literal) @number

(real_literal) @number.float

(variable) @variable

((variable) @variable.builtin
  (#any-of? @variable.builtin
    "$$" "$?" "$^" "$_" "$args" "$ConsoleFileName" "$EnabledExperimentalFeatures" "$Error" "$Event"
    "$EventArgs" "$EventSubscriber" "$ExecutionContext" "$false" "$foreach" "$HOME" "$Host" "$input"
    "$IsCoreCLR" "$IsLinux" "$IsMacOS" "$IsWindows" "$LASTEXITCODE" "$Matches" "$MyInvocation"
    "$NestedPromptLevel" "$null" "$PID" "$PROFILE" "$PSBoundParameters" "$PSCmdlet" "$PSCommandPath"
    "$PSCulture" "$PSDebugContext" "$PSEdition" "$PSHOME" "$PSItem" "$PSScriptRoot" "$PSSenderInfo"
    "$PSUICulture" "$PSVersionTable" "$PWD" "$Sender" "ShellId" "$StackTrace" "$switch" "$this"
    "$true"))

((variable) @variable.builtin
  (#lua-match? @variable.builtin "^\$env:"))

(data_name
  (simple_name) @constant)

(comment) @comment @spell

((program
  .
  (comment) @keyword.directive)
  (#lua-match? @keyword.directive "^#!/"))

; Booleans
;---------
([
  (generic_token)
  (command_name)
  (variable)
  (command)
] @boolean
  (#any-of? @boolean "True" "False" "$true" "$false"))

; switch -regex
;--------------
(switch_statement
  (switch_parameters
    (switch_parameter) @_parameter)
  (switch_body
    (switch_clauses
      (switch_clause
        (switch_clause_condition
          (string_literal) @string.regexp))))
  (#eq? @_parameter "-regex")
  (#offset! @string.regexp 0 1 0 -1))

; Multiline strings
;------------------
([
  (verbatim_here_string_characters)
  (expandable_here_string_literal)
] @markup.raw.block
  (#offset! @markup.raw.block 0 2 0 -2))

; Type references and definitions
;--------------------------------
(type_spec
  (type_name) @type)

(class_statement
  (simple_name) @type)

(type_spec
  (type_name) @type.builtin
  (#any-of? @type.builtin
    "bool" "Boolean" "System.Boolean" "char" "Char" "System.Char" "string" "String" "System.String"
    "int" "Int32" "System.Int32" "long" "Int64" "System.Int64" "byte" "Byte" "System.Byte" "float"
    "Single" "System.Single" "double" "Double" "System.Double" "decimal" "Decimal" "System.Decimal"
    "array" "Array" "System.Array" "regex" "Regex" "System.Text.RegularExpressions.Regex" "ref"
    "Management.Automation.PSReference" "System.Management.Automation.PSReference" "scriptblock"
    "Management.Automation.ScriptBlock" "System.Management.Automation.ScriptBlock" "datetime"
    "DateTime" "System.DateTime" "enum" "Enum" "System.Enum" "IO.DirectoryInfo"
    "System.IO.DirectoryInfo" "IO.FileAttributes" "System.IO.FileAttributes" "IO.FileInfo"
    "System.IO.FileInfo" "IO.Path" "System.IO.Path" "Text.RegularExpressions.RegexOptions"
    "System.Text.RegularExpressions.RegexOptions" "Math" "System.Math" "PSObject" "System.PSObject"
    "Object" "System.Object" "ValueType" "System.ValueType" "Hashtable"
    "System.Collections.Hashtable" "Collections.Stack" "System.Collections.Generic.Stack"
    "Collections.Dictionary" "System.Collections.Dictionary" "Collections.DictionaryEntry"
    "System.Collections.DictionaryEntry" "Collections.ArrayList" "System.Collections.ArrayList"
    "Management.Automation.SwitchParameter" "System.Management.Automation.SwitchParameter"
    "Management.Automation.ActionPreference" "System.Management.Automation.ActionPreference"
    "Management.Automation.ConfirmImpact" "System.Management.Automation.ConfirmImpact"
    "Management.Automation.CommandInfo" "System.Management.Automation.CommandInfo"
    "Management.Automation.ProviderInfo" "System.Management.Automation.ProviderInfo"
    "Management.Automation.PSDriveInfo" "System.Management.Automation.PSDriveInfo"
    "Management.Automation.PSVariable" "System.Management.Automation.PSVariable"
    "Management.Automation.AliasInfo" "System.Management.Automation.AliasInfo"
    "Management.Automation.PathInfo" "System.Management.Automation.PathInfo"
    "Management.Automation.PathInfoStack" "System.Management.Automation.PathInfoStack"
    "Management.Automation.ApplicationInfo" "System.Management.Automation.ApplicationInfo"
    "Management.Automation.CmdletInfo" "System.Management.Automation.CmdletInfo"
    "Management.Automation.ExternalScriptInfo" "System.Management.Automation.ExternalScriptInfo"
    "Management.Automation.FunctionInfo" "System.Management.Automation.FunctionInfo"
    "Management.Automation.CommandTypes" "System.Management.CommandTypes"
    "Management.Automation.ScopedItemOptions" "System.Management.Automation.ScopedItemOptions"
    "Management.Automation.PSTypeName" "System.Management.Automation.PSTypeName"
    "Management.Automation.ParameterMetadata" "System.Management.Automation.ParameterMetadata"
    "Management.Automation.CommandParameterSetInfo"
    "System.Management.Automation.CommandParameterSetInfo"
    "Management.Automation.SessionStateEntryVisibility"
    "System.Management.Automation.SessionStateEntryVisibility" "Management.Automation.FilterInfo"
    "System.Management.Automation.FilterInfo" "Management.Automation.ModuleType"
    "System.Management.Automation.ModuleType" "Management.Automation.PSModuleInfo"
    "System.Management.Automation.PSModuleInfo" "Management.Automation.PSCustomObject"
    "System.Management.Automation.PSCustomObject" "Management.Automation.PSScriptCmdlet"
    "System.Management.Automation.PSScriptCmdlet" "Management.Automation.ErrorRecord"
    "System.Management.Automation.ErrorRecord" "Management.Automation.PSCredential"
    "System.Management.Automation.PSCredential" "Management.Automation.PSMethod"
    "System.Management.Automation.PSMethod"))

; Function definitions
;---------------------
(function_statement
  (function_name) @function)

; Classes, fields and methods definitions
;----------------------------------------
(class_property_definition
  (variable) @variable.member)

(class_method_definition
  (simple_name) @function.method)

(class_statement
  (simple_name) @_class_name
  (class_method_definition
    (simple_name) @constructor)
  (#eq? @constructor @_class_name))

(key_expression) @property

; Functions, methods calls and properties access
;--------------------------
(command_invokation_operator) @operator

(invokation_expression
  (member_name) @function.call)

(invokation_expression
  (member_name) @constructor
  (#eq? @constructor "new"))

(member_access
  (member_name
    [
      (simple_name)
      (variable)
    ] @variable.member))

; Commands execution
;-------------------
(command
  command_name: (command_name) @function.call)

(command
  command_name: (command_name) @function.builtin
  (#any-of? @function.builtin
    ; Locations & Paths
    "cd" "cd.." "cd\\" "cd~" "help" "Get-Location" "Pop-Location" "Push-Location" "Set-Location"
    "Convert-Path" "Join-Path" "Resolve-Path" "Split-Path" "Test-Path"
    ; Files & Directories
    "Clear-Item" "Clear-ItemProperty" "Copy-Item" "Copy-ItemProperty" "Get-Item" "Get-ItemProperty"
    "Get-ItemPropertyValue" "Invoke-Item" "Move-Item" "Move-ItemProperty" "New-Item"
    "New-ItemProperty" "Remove-Item" "Remove-ItemProperty" "Rename-Item" "Rename-ItemProperty"
    "Set-Item" "Set-ItemProperty"
    ; Aliases
    "New-Alias" "Get-Alias" "Set-Alias" "Remove-Alias" "Import-Alias" "Export-Alias"
    ; Host (prompt)
    "prompt" "cls" "echo" "Clear-Host" "Get-Host" "Out-Host" "Read-Host" "Write-Host" "Out-String"
    ; Expressions
    "Invoke-Expression"
    ; Objects
    "Compare-Object" "ForEach-Object" "Group-Object" "Measure-Object" "New-Object" "Select-Object"
    "Sort-Object" "Tee-Object" "Where-Object"
    ; Modules
    "Export-ModuleMember" "Find-Module" "Get-Module" "Import-Module" "Install-Module" "New-Module"
    "New-ModuleManifest" "Publish-Module" "Remove-Module" "Save-Module" "Test-ModuleManifest"
    "Uninstall-Module" "Update-Module" "Update-ModuleManifest"))

; Parameters and call arguments
;------------------------------
(command_elements
  (generic_token) @variable.parameter)

(switch_parameter) @variable.parameter.builtin

(command_parameter) @variable.parameter.builtin

(script_parameter
  (variable) @variable.parameter)

(class_method_parameter
  (variable) @variable.parameter)

; Document encoding
;------------------
((program
  .
  (comment) @keyword.directive @nospell)
  (#lua-match? @keyword.directive "Encoding$"))
