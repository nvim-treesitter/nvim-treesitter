; Copyright 2025 International Digital Economy Academy
;
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
;
;     http://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.
; Definitions
; Functions
(function_definition
  (function_identifier) @local.definition.function)

; Variables
(value_definition
  (lowercase_identifier) @local.definition.var)

(parameter
  (parameter_label) @local.definition.parameter)

(let_expression
  (pattern
    (simple_pattern
      (lowercase_identifier)) @local.definition.var))

(let_mut_expression
  (lowercase_identifier) @local.definition.var)

; Types
(struct_definition
  (identifier) @local.definition.type)

(enum_definition
  (identifier) @local.definition.enum)

(type_definition
  (identifier) @local.definition.type)

(type_identifier) @local.definition.type

; References
; Values
(qualified_identifier) @local.reference

; Types
(qualified_type_identifier) @local.reference

; Scopes
[
  (structure)
  (function_definition)
  (anonymous_lambda_expression)
  (named_lambda_expression)
  (block_expression)
] @local.scope
