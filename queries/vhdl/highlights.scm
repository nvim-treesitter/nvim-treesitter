; 15.10 Reserved words {{{
[
   "abs"
   "access"
   "after"
   "alias"
   "all"
   "and"
   "architecture"
   "array"
   "assert"
   "assume"
   "assume_guarantee"
   "attribute"

   "begin"
   "block"
   "body"
   "buffer"
   "bus"

   "case"
   "component"
   "configuration"
   "constant"
   "context"
   "cover"

   "default"
   "disconnect"
   "downto"

   "else"
   "elsif"
   "end"
   "entity"
   "exit"

   "fairness"
   "file"
   "for"
   "force"
   "function"

   "generate"
   "generic"
   "group"
   "guarded"

   "if"
   "impure"
   "in"
   "inertial"
   "inout"
   "is"

   "label"
   "library"
   "linkage"
   "literal"
   "loop"

   "map"
   "mod"

   "nand"
   "new"
   "next"
   "nor"
   "not"
   "null"

   "of"
   "on"
   "open"
   "or"
   "others"
   "out"

   "package"
   "parameter"
   "port"
   "postponed"
   "procedure"
   "process"
   "property"
   "protected"
   "pure"

   "range"
   "record"
   "register"
   "reject"
   "release"
   "rem"
   "report"
   "restrict"
   "restrict_guarantee"
   "return"
   "rol"
   "rol"

   "select"
   "sequence"
   "severity"
   "shared"
   "signal"
   "sla"
   "sll"
   "sra"
   "srl"
   "strong"
   "subtype"

   "then"
   "to"
   "transport"
   "type"

   "unaffected"
   "units"
   "until"
   "use"

   "variable"
   "vmode"
   "vprop"
   "vunit"

   "wait"
   "when"
   "while"
   "with"

   "xnor"
   "xor"
] @keyword

(operator_symbol) @operator

[ "==" "!=" ] @operator @error

[
   ":"
   "|"
   ","
   "."
   ";"
   "'"
   (semicolon)
] @punctuation.delimiter

[
   "@"
   "^."
   "/" ; PSL
] @punctuation.special

[
   "("
   ")"
   "["
   "]"
   "{"
   "}"
   "<<"
   ">>"
] @punctuation.bracket

[
   (all)
   (any)
   (same)
   (open)
   (others)
   (null)
   (null_statement)
   (unaffected)
   (default)
] @constant.builtin
; }}}
; 3.2 Entity declarations {{{
(entity_declaration
   ["entity" "is" "end"] @keyword.unit.primary)

(entity_declaration
   (header
      (_ ["generic" "port" "map" ] @keyword.unit.primary)))

(entity_declaration . [
   (identifier)
   (extended_identifier)
] @constant @constant.unit.primary)

(entity_declaration at_end: [
   (simple_name)
   (extended_simple_name)
] @constant @constant.unit.primary)
; }}}
; 3.3 Architecture bodies {{{
(architecture_body
   ["architecture" "of" "is" "begin" "end"] @keyword.unit.secondary)

(architecture_body . [
   (identifier)
   (extended_identifier)
] @constant @constant.unit.secondary)

(architecture_body entity: [
   (simple_name)
   (extended_simple_name)
] @constant @constant.unit.primary)

(architecture_body at_end: [
   (simple_name)
   (extended_simple_name)
] @constant @constant.unit.secondary)
; }}}
; 3.4 Configuration declarations {{{
(configuration_declaration
   ["configuration" "is" "begin" "end"] @keyword.unit.secondary)

(configuration_declaration . [
   (identifier)
   (extended_identifier)
] @constant @constant.unit.primary)

(configuration_declaration entity: [
   (simple_name)
   (extended_simple_name)
] @constant @constant.unit.primary)

(configuration_declaration at_end: [
   (simple_name)
   (extended_simple_name)
] @constant @constant.unit.primary)
; }}}
; 3.4.2 Block configuration {{{
(block_specification [
   (simple_name)
   (extended_simple_name)
] @label)
; }}}
; 3.4.3 Component configuration {{{
; }}}
; 4.2.1 Subprogram declarations {{{
(subprogram_header
   (_ ["generic" "port" "map" ] @keyword.function))

;; Procedure declaration
(procedure_declaration
   "procedure" @keyword.function)

(procedure_declaration . [
   (identifier)
   (extended_identifier)
] @function @subprogram.procedure)

;; Function declaration
(function_declaration
   "function" @keyword.function)

(function_declaration . [
   (identifier)
   (extended_identifier)
] @function @subprogram.function)
; }}}
; 4.3 Subprogram bodies {{{
;; Procedure body
(procedure_body
   ["procedure" "is" "begin" "end"] @keyword.function)

(procedure_body . [
   (identifier)
   (extended_identifier)
] @function @subprogram.procedure)

(procedure_body at_end: [
   (simple_name)
   (extended_simple_name)
] @function @subprogram.procedure)

;; Function body
(function_body 
   [ "pure" "impure" "function" "is" "begin" "end" ] @keyword.function)

(function_body
   (return
      "return" @keyword.function))

(function_body . [
   (identifier)
   (extended_identifier)
] @function @subprogram.function)

(function_body at_end: [
   (simple_name)
   (extended_simple_name)
] @function @subprogram.function)
;; }}}
; 4.4 Subprogram instantiation declarations {{{
;; Procedure instantiation declarations {{{
(procedure_instantiation_declaration
   ["procedure" "pure" "impure" "is"] @constructor)

(procedure_instantiation_declaration
   (signature
      (return "return" @constructor)))

(procedure_instantiation_declaration
   (instantiation_declaration_map_aspect
      (_ ["generic" "port" "map" ] @constructor)))

(procedure_instantiation_declaration . [
   (identifier)
   (extended_identifier)
   (selected_name suffix: [
      (simple_name)
      (extended_simple_name)
   ] @function @subprogram.procedure .)
] @function @subprogram.procedure)
;; }}}
;; Function instantiation declarations {{{
(function_instantiation_declaration
   ["function" "pure" "impure" "is"] @constructor)

(function_instantiation_declaration
   (signature
      (return "return" @constructor)))

(function_instantiation_declaration
   (instantiation_declaration_map_aspect
      (_ ["generic" "port" "map" ] @constructor)))

(function_instantiation_declaration . [
   (identifier)
   (extended_identifier)
   (selected_name suffix: [
      (simple_name)
      (extended_simple_name)
   ] @function @subprogram.function .)
] @function @subprogram.function)
;; }}}
;; }}}
; 4.5.3 Signatures {{{
(signature
   ["[" "]"] @punctuation.bracket.signature)
; }}}
; 4.7 Package declarations {{{
(package_declaration
   ["package" "is" "end"] @keyword.unit.primary)

(package_declaration
   (header
      (_ ["generic" "port" "map" ] @keyword.unit.primary)))

(package_declaration . [
   (identifier) (extended_identifier)
] @constant @constant.unit.primary)

(package_declaration at_end: [
   (simple_name)
   (extended_simple_name)
] @constant @constant.unit.primary)
; }}}
; 4.8 Package bodies {{{
(package_body
   ["package" "body" "is" "end"] @keyword.unit.secondary)

(package_body . [
   (simple_name)
   (extended_simple_name)
] @constant @constant.unit.primary)

(package_body at_end: [
   (simple_name)
   (extended_simple_name)
] @constant @constant.unit.primary)
; }}}
; 4.9 Package instantiation declarations {{{
(design_unit
   (package_instantiation_declaration
      ["package" "is"] @keyword.unit.primary))

(design_unit
   (package_instantiation_declaration
      (instantiation_declaration_map_aspect
         (_ ["generic" "port" "map" ] @keyword.unit.primary))))

(declarative_part
   (package_instantiation_declaration
      ["package" "is"] @constructor))

(declarative_part
   (package_instantiation_declaration
      (instantiation_declaration_map_aspect
         (_ ["generic" "port" "map" ] @constructor))))

(package_instantiation_declaration [
   (simple_name)
   (extended_simple_name)
   (selected_name suffix: [
      (simple_name)
      (extended_simple_name)
   ] @constant @constant.unit.primary .)
] @constant @constant.unit.primary)
; }}}
; 5.2.2 Enumeration types {{{
(enumeration_type_definition [
   (identifier)
   (extended_identifier)
] @character)
; }}}
; 5.2.4 Physical types {{{
(primary_unit_declaration [
   (identifier)
   (extended_identifier)
] @constant @constant.unit)

(secondary_unit_declaration [
   (identifier)
   (extended_identifier)
] @constant @constant.unit)

(physical_type_definition at_end: [
   (simple_name)
   (extended_simple_name)
] @type @type.scalar.physical)

(physical_literal [
   (simple_name)
   (extended_simple_name)
] @constant @constant.unit)
; }}}
; 5.3.2 Array types {{{
; Discrete range shall be constant in for generate, choices, etc
((simple_name) @constant.object.constant
 (#has-ancestor? @constant.object.constant ascending_range descending_range)
 (#has-ancestor? @constant.object.constant for_generate_statement choices numeric_type_definition array_constraint range_constraint)
 (#not-has-parent? @constant.object.constant selected_name ambiguous_name slice_name function_call attribute_name))

((extended_simple_name) @constant.object.constant
 (#has-ancestor? @constant.object.constant ascending_range descending_range)
 (#has-ancestor? @constant.object.constant for_generate_statement choices numeric_type_definition array_constraint range_constraint)
 (#not-has-parent? @constant.object.constant selected_name ambiguous_name slice_name function_call attribute_name))
; }}}
; 5.3.3 Record types {{{
(record_type_definition at_end: [
   (simple_name)
   (extended_simple_name)
] @type @type.composite.record .)

(element_declaration
   (identifier_list [
      (identifier)
      (extended_identifier)
   ] @field @field.record))

(record_element_constraint [
   (simple_name)
   (extended_simple_name)
] @field @field.record)
; }}}
; 5.4.2 Incomplete type declarations {{{
(incomplete_type_declaration . [
   (identifier)
   (extended_identifier)
] @type @type.incomplete)
; }}}
; 5.4.3 Allocation and deallocation of objects {{{
(procedure_call_statement
   procedure: (simple_name) @function.builtin @subprogram.procedure.builtin
              (#match? @function.builtin "^[dD][eE][aA][lL][lL][oO][cC][aA][tT][eE]$"))
; }}}
; 5.6.2 Protected type declarations {{{
(protected_type_declaration at_end: [
   (simple_name)
   (extended_simple_name)
] @type @type.protected)
; }}}
; 5.6.3 Protected type bodies {{{
(protected_type_body at_end: [
   (simple_name)
   (extended_simple_name)
] @type @type.protected)
; }}}
; 6.2 Type declarations {{{
(full_type_declaration [
   ; Scalar types
   ([(identifier) (extended_identifier)] @type @type.scalar.enumeration
      (enumeration_type_definition))
   ([(identifier) (extended_identifier)] @type @type.scalar.numeric
      (numeric_type_definition))
   ([(identifier) (extended_identifier)] @type @type.scalar.physical
      (physical_type_definition))
   ; Composite types
   ([(identifier) (extended_identifier)] @type @type.composite.array.unbounded
      (unbounded_array_definition))
   ([(identifier) (extended_identifier)] @type @type.composite.array.constrained
      (constrained_array_definition))
   ([(identifier) (extended_identifier)] @type @type.composite.record
      (record_type_definition))
   ; Others types
   ([(identifier) (extended_identifier)] @type @type.access
      (access_type_definition))
   ([(identifier) (extended_identifier)] @type @type.file
      (file_type_definition))
   ; Protected types
   ([(identifier) (extended_identifier)] @type @type.protected
      (protected_type_declaration))
   ([(identifier) (extended_identifier)] @type @type.protected
      (protected_type_body))
])
; }}}
; 6.3 Subtype declarations {{{
(subtype_declaration . [
   (identifier)
   (extended_identifier)
] @type)

(resolution_function [
   (simple_name)
   (extended_simple_name)
   (selected_name suffix: [
      (simple_name)
      (extended_simple_name)
   ] @function @subprogram.function.resolution .)
] @function @subprogram.function.resolution)

(record_element_resolution [
   (simple_name)
   (extended_simple_name)
] @field @field.record)

(type_mark [
   (simple_name)
   (extended_simple_name)
   (selected_name suffix: [
      (simple_name)
      (extended_simple_name)
   ] @type .)
] @type)
; }}}
; 6.4.2 Object declarations {{{
(constant_declaration
   (identifier_list [ (identifier) (extended_identifier) ] @constant.object.constant))

(signal_declaration
   (identifier_list [ (identifier) (extended_identifier) ] @variable.object.signal))

(variable_declaration
   (identifier_list [ (identifier) (extended_identifier) ] @variable.object.variable))

(shared_variable_declaration
   (identifier_list [ (identifier) (extended_identifier) ] @variable.object.variable @variable.object.variable.shared))

(file_declaration
   (identifier_list [ (identifier) (extended_identifier) ] @constant.object.file))
; }}}
; 6.5 Interface declarations {{{
(mode [
   "in"      @keyword.mode.in
   "out"     @keyword.mode.out
   "inout"   @keyword.mode.inout
   "buffer"  @keyword.mode.buffer
   "linkage" @keyword.mode.linkage
])

;; Constant
(constant_interface_declaration
   (identifier_list [(identifier) (extended_identifier)] @parameter))

;; Signal
(signal_interface_declaration
   (identifier_list [(identifier) (extended_identifier)] @parameter))

(signal_interface_declaration [
   ((identifier_list [(identifier) (extended_identifier)] @variable.object.signal.in)      . (mode "in"))
   ((identifier_list [(identifier) (extended_identifier)] @variable.object.signal.out)     . (mode "out"))
   ((identifier_list [(identifier) (extended_identifier)] @variable.object.signal.inout)   . (mode "inout"))
   ((identifier_list [(identifier) (extended_identifier)] @variable.object.signal.buffer)  . (mode "buffer"))
   ((identifier_list [(identifier) (extended_identifier)] @variable.object.signal.linkage) . (mode "linkage"))
   ; Default, when mode is not present
   ((identifier_list [(identifier) (extended_identifier)] @variable.object.signal.in)      . (subtype_indication))
])

;; Variable
(variable_interface_declaration
   (identifier_list [(identifier) (extended_identifier)] @parameter))

(variable_interface_declaration   [
   ((identifier_list [(identifier) (extended_identifier)] @variable.object.variable.in)    . (mode "in"))
   ((identifier_list [(identifier) (extended_identifier)] @variable.object.variable.out)   . (mode "out"))
   ((identifier_list [(identifier) (extended_identifier)] @variable.object.variable.inout) . (mode "inout"))
   ; Default, when mode is not present
   ((identifier_list [(identifier) (extended_identifier)] @variable.object.variable.in)    . (subtype_indication))
])

;; File
(file_interface_declaration
   (identifier_list [(identifier) (extended_identifier)] @parameter @constant.object.file))
; }}}
; 6.5.3 Interface type declarations {{{
(type_interface_declaration
   [(identifier) (extended_identifier)] @type)
; }}}
; 6.5.4 Interface subprogram declarations {{{
(procedure_interface_declaration
  "is" @keyword.function)

(procedure_interface_declaration
   (interface_subprogram_default
      (_ ["generic" "port" "map" ] @keyword.function)))

(procedure_interface_declaration
   (interface_subprogram_default [
      (simple_name)
      (extended_simple_name)
      (selected_name suffix: [
         (simple_name)
         (extended_simple_name)
      ] @function @subprogram.procedure .)
   ] @function @subprogram.procedure))

(function_interface_declaration
  "is" @keyword.function)

(function_interface_declaration
   (interface_subprogram_default
      (_ ["generic" "port" "map" ] @keyword.function)))

(function_interface_declaration
   (interface_subprogram_default [
      (simple_name)
      (extended_simple_name)
      (selected_name suffix: [
         (simple_name)
         (extended_simple_name)
      ] @function @subprogram.function .)
   ] @function @subprogram.function))
;; }}}
; 6.5.5 Interface package declarations {{{
(package_interface_declaration
   ["package" "is"] @keyword.unit.primary)

(package_interface_declaration
   (map_aspect
      (_ ["generic" "port" "map" ] @keyword.unit.primary)))

(package_interface_declaration . [
   (identifier)
   (extended_identifier)
      (selected_name suffix: [
         (simple_name)
         (extended_simple_name)
      ] @constant @constant.unit.primary .)
   ] @constant @constant.unit.primary)
; }}}
; 6.7 Attribute declarations {{{
(attribute_declaration . [
   (identifier)
   (extended_identifier)
] @attribute)
; }}}
; 6.8 Component declarations {{{
(component_declaration . [
   (identifier)
   (extended_identifier)
] @constant @constant.unit.primary)

(component_declaration at_end: [
   (simple_name)
   (extended_simple_name)
] @constant @constant.unit.primary .)
; }}}
; 6.9 Group template declarations {{{
(group_template_declaration . [
   (identifier)
   (extended_identifier)
] @constant @group)
; }}}
; 6.10 Group declarations {{{
(group_declaration . [
   (identifier)
   (extended_identifier)
] @constant @group)
; }}}
; 7.2 Specifications {{{
(attribute_specification [
   (simple_name)
   (extended_simple_name)
] @attribute)

(entity_specification [
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)] @constant    @constant.unit.primary    )) (entity_class "entity"        ))
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)] @constant    @constant.unit.secondary  )) (entity_class "architecture"  ))
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)] @constant    @constant.unit.primary    )) (entity_class "configuration" ))
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)] @function    @subprogram.procedure     )) (entity_class "procedure"     ))
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)] @function    @subprogram.function      )) (entity_class "function"      ))
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)] @constant    @constant.unit.primary    )) (entity_class "package"       ))
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)] @type                                  )) (entity_class "type"          ))
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)] @type        @type.subtype             )) (entity_class "subtype"       ))
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)]              @constant.object.constant )) (entity_class "constant"      ))
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)]              @variable.object.signal   )) (entity_class "signal"        ))
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)]              @variable.object.variable )) (entity_class "variable"      ))
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)] @constant    @constant.unit.primary    )) (entity_class "component"     ))
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)] @label                                 )) (entity_class "label"         ))
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)] @character                             )) (entity_class "literal"       ))
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)] @constant    @unit                     )) (entity_class "units"         ))
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)] @constant    @group                    )) (entity_class "group"         ))
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)] @constant    @constant.object.file     )) (entity_class "file"          ))
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)] @constant    @psl.property             )) (entity_class "property"      ))
   ((entity_name_list (entity_designator [(simple_name) (extended_simple_name)] @constant    @psl.sequence             )) (entity_class "sequence"      ))
])
; }}}
; 7.3 Configuration specification {{{
(instantiation_list label: [
   (simple_name)
   (extended_simple_name)
] @label)

(configuration_specification component: [
   (simple_name)
   (extended_simple_name)
] @constant @constant.unit.primary)

(component_configuration component: [
   (simple_name)
   (extended_simple_name)
] @constant @constant.unit.primary)
; }}}
; 7.3.2 Binding indication {{{
(binding_indication
   "use" @include)

(binding_indication
   (map_aspect
      (_ ["generic" "port" "map" ] @include)))
; }}}
; 7.3.4 Verification unit binding indication {{{
(verification_unit_binding_indication
   ["use" "vunit"] @include)

(verification_unit_list [
   (simple_name)
   (extended_simple_name)
   (selected_name suffix: [
      (simple_name)
      (extended_simple_name)
   ] @constant @constant.unit.primary .)
] @constant @psl.vunit)
; }}}
; 8.3 Selected names {{{
(selected_name
   prefix: [(simple_name) (extended_simple_name)] @variable.access
   suffix: (all))

(expanded_name
   prefix: [(simple_name) (extended_simple_name)] @constant @constant.unit.primary)

((expanded_name
  suffix: [(simple_name) (extended_simple_name)] @constant @constant.unit.secondary) @_c
 (#has-parent? @_c configuration_declaration architecture_body))


(expanded_name
   prefix: (selected_name
               prefix: [(simple_name) (extended_simple_name)] @namespace
               suffix: [(simple_name) (extended_simple_name)] @constant @constant.unit.primary))
; }}}
; 8.3.2 Binding indication {{{
(entity_aspect [
   configuration:  [(simple_name) (extended_simple_name)] @constant @constant.unit.primary
   entity:         [(simple_name) (extended_simple_name)] @constant @constant.unit.primary
   architecture:   [(simple_name) (extended_simple_name)] @constant @constant.unit.secondary
   configuration:  (selected_name
                      suffix: [(simple_name) (extended_simple_name)] @constant @primary.configuration .)
   entity:        (selected_name
                      suffix: [(simple_name) (extended_simple_name)] @constant @constant.unit.primary .)
])
; }}}
; 8.6 Attribute names {{{
(attribute_name
   "'" @attribute.delimiter
   designator: _ @attribute)

(predefined_designator) @attribute.builtin

;; 16.2.4 Predefined attributes of signals
(attribute_name
      prefix: [(simple_name) (extended_simple_name)] @variable.object.signal
  designator: (predefined_designator [
                  "value"
                  "pos"
                  "val"
                  "succ"
                  "pred"
                  "rightof"
                  "leftof"]))

(attribute_name
      prefix: [(simple_name) (extended_simple_name)] @type
  designator: (predefined_designator "image"))
; }}}
; 8.7 External names {{{
(package_pathname
   "@" @library.delimiter)

(relative_pathname
   "^." @package.delimiter)

(package_pathname library: [
   (simple_name)
   (extended_simple_name)
] @namespace)

(package_pathname package: [
   (simple_name)
   (extended_simple_name)
] @constant @constant.unit.primary)

(pathname_element [
   (simple_name)
   (extended_simple_name)
] @label)

(generate_statement_element label: [
   (simple_name)
   (extended_simple_name)
] @label)

(external_constant_name
   (_ object: [
      (simple_name)
      (extended_simple_name)
   ] @constant.object.constant))

(external_signal_name
   (_ object: [
      (simple_name)
      (extended_simple_name)
   ] @variable.object.signal))

(external_variable_name
   (_ object: [
      (simple_name)
      (extended_simple_name)
   ] @variable.object.variable))
; }}}
; 9. Expressions {{{
(parenthesized_expression
  ["(" ")"] @operator)

((simple_name) @constant.object.constant
 (#has-ancestor? @constant.object.constant default_expression))

((extended_identifier) @constant.object.constant
 (#has-ancestor? @constant.object.constant default_expression))

(condition
   operator: _ @operator)

(logical_expression
   operator: _ @operator)

(relation
   operator: _ @operator)

(shift_expression
   operator: _ @operator)

(concatenation
   operator: _ @operator)

(simple_expression
   operator: _ @operator)

(sign
   operator: _ @operator)

(term
   operator: _ @operator)

(factor
   operator: _ @operator)

(exponentiation
   operator: _ @operator)

(reduction
   operator: _ @operator)


; }}}
; 9.3.4 Function call {{{
(function_call [
   (simple_name)
   (extended_simple_name)
   (selected_name suffix: [
      (simple_name)
      (extended_simple_name)
   ] @function @subprogram.function .)
] @function @subprogram.function)
; }}}
; 9.3.5 Qualified expressions {{{
; }}}
; 9.3.7 Allocators {{{
"new" @keyword.operator @keyword.operator.new
; }}}
; 10.2 Wait statement {{{
(wait_statement
  ["wait" "on" "until" "for"] @conditional)

(sensitivity_list [
   (simple_name)
   (extended_simple_name)
] @variable.object.signal)

(sensitivity_list
  (all) @constant.signal.all)
; }}}
; 10.3 Assertion statement {{{
(assertion_statement
   ["assert" "report" "severity"] @exception)
; }}}
; 10.4 Report statement {{{
(report_statement
   ["report" "severity"] @exception)
; }}}
; 10.5 Signal assignments {{{
(signal_assignment_statement
    (delay_mechanism [
        (transport "transport" @conditional)
        (inertial ["reject" "inertial"] @conditional) ])
    [(conditional_waveforms) (selected_waveforms)])

(signal_assignment_statement
   "force" @conditional
   [(conditional_expressions) (selected_expressions)])

(force_mode) @constant.builtin

(signal_assignment_statement target: [
   (simple_name) @variable.object.signal
   (extended_simple_name) @variable.object.signal
   (selected_name
      prefix: [(simple_name) (extended_simple_name)] @variable.object.signal
      suffix: [(simple_name) (extended_simple_name)] @field @field.record)
   ])

(signal_assignment_statement
   target: (aggregate
               (positional_element_association
                  (expression [
                    (simple_name) @variable.object.signal
                    (extended_simple_name) @variable.object.signal
                    (selected_name
                        prefix: [(simple_name) (extended_simple_name)] @variable.object.signal
                        suffix: [(simple_name) (extended_simple_name)] @field @field.record)
                  ]))))
; }}}
; 10.5.2 Selected signal assignments {{{
; }}}
; 10.5.3 Conditional signal assignments {{{
(conditional_waveforms
   "when" @conditional)

(alternative_conditional_waveforms
   ["else" "when"] @conditional)

(alternative_conditional_waveforms
   (waveforms
      (waveform_element "after" @conditional)))

(conditional_waveforms
   (waveforms
      (waveform_element "after" @conditional)))

(conditional_expressions
   "when" @conditional)

(alternative_conditional_expressions
   ["when" "else"] @conditional)
; }}}
; 10.5.4 Selected signal assignments {{{
(signal_assignment_statement
   ["with" "select" "?" "guarded"] @conditional)

(selected_waveforms
   "when" @conditional)

(alternative_selected_waveforms
   "when" @conditional)

(selected_waveforms
   (waveforms
      (waveform_element "after" @conditional)))

(selected_expressions
   "when" @conditional)

(alternative_selected_expressions
   "when" @conditional)
; }}}
; 10.6 Variable assignments {{{
(variable_assignment_statement
  ["with" "select"] @conditional)

(variable_assignment_statement target: [
   (simple_name) @variable.object.variable
   (extended_simple_name) @variable.object.variable
   (selected_name
      prefix: [(simple_name) (extended_simple_name)] @variable.object.variable
      suffix: [(simple_name) (extended_simple_name)] @field @field.record)
   ])

(variable_assignment_statement
   target: (aggregate
               (positional_element_association
                  (expression [
                    (simple_name) @variable.object.variable
                    (extended_simple_name) @variable.object.variable
                    (selected_name
                        prefix: [(simple_name) (extended_simple_name)] @variable.object.variable
                        suffix: [(simple_name) (extended_simple_name)] @field @field.record)
                  ]))))
; }}}
; 10.7 Procedure call statement {{{
(procedure_call_statement
   (simple_name) @function @subprogram.procedure)
; }}}
; 10.8 If statement {{{
(if_statement
   ["end" "if"] @conditional)

(if
   ["if" "then"] @conditional)

(elsif
   ["elsif" "then"] @conditional)

(else "else" @conditional)

(if_statement at_end: [
   (simple_name)
   (extended_simple_name)
] @label .)
; }}}
; 10.9 Case statement {{{
(case_statement
   ["case" "?" "is" "end"] @conditional)

(case_statement_alternative "when" @conditional)

; Assume name on case statement alternative is an enumerator
; (not always the case, can be constant) FIXME
(case_statement_alternative
   (choices
      (simple_expression
         [(simple_name) (extended_simple_name)] @character)))


(case_statement at_end: [
   (simple_name)
   (extended_simple_name)
] @label .)
; }}}
; 10.10 Loop statement {{{
(loop_statement
   ["loop" "end" "loop"] @repeat)

(while_loop "while" @repeat)

(for_loop "for" @repeat)
   (parameter_specification "in" @repeat)

((wait_statement "wait" @repeat)
   (#has-ancestor? @repeat loop_statement))

; Accordingly with the LRM, the paramater is a constant
(parameter_specification . [
    (identifier)
    (simple_expression)
] @constant.object.constant)

(parameter_specification [
  (descending_range "downto" @repeat)
  (ascending_range  "to" @repeat)
])
; }}}
; 10.11 Next statement {{{
(next_statement
   ["next" "when"] @repeat)
; }}}
; 10.12 Exit statement {{{
(exit_statement
   ["exit" "when"] @repeat)
; }}}
; 10.12 Exit statement {{{
(return_statement
   "return" @keyword.function)
; }}}
; 11.2 Block statement {{{
(block_statement at_end: [
   (simple_name)
   (extended_simple_name)
] @label .)
; }}}
; 11.3 Process statement {{{
(process_statement at_end: [
   (simple_name)
   (extended_simple_name)
] @label .)
; }}}
; 12.4 Use clauses {{{
(use_clause
  "use" @include)
; }}}
; 11.6 Concurrent signal assignments {{{
(concurrent_signal_assignment
   ["with" "select" "?"] @conditional)

(concurrent_signal_assignment
    (delay_mechanism [
        (transport "transport" @conditional)
        (inertial ["reject" "inertial"] @conditional) ])
    [(conditional_waveforms) (selected_waveforms)])

(concurrent_signal_assignment
    "guarded" @conditional
    [(conditional_waveforms) (selected_waveforms)])

(concurrent_signal_assignment target: [
   (simple_name) @variable.object.signal
   (extended_simple_name) @variable.object.signal
   (selected_name
      prefix: [(simple_name) (extended_simple_name)] @variable.object.signal
      suffix: [(simple_name) (extended_simple_name)] @field @field.record)
   ])

(concurrent_signal_assignment
   target: (aggregate
               (positional_element_association
                  (expression [
                    (simple_name) @variable.object.signal
                    (extended_simple_name) @variable.object.signal
                    (selected_name
                        prefix: [(simple_name) (extended_simple_name)] @variable.object.signal
                        suffix: [(simple_name) (extended_simple_name)] @field @field.record)
                  ]))))
; }}}
; 11.7 Component instantiation statements {{{
(component_instantiation_statement
   (map_aspect
      (_ ["generic" "port" "map" ] @constructor)))

(component_instantiation_statement
   ["entity" "configuration" "component"] @constructor)

(component_instantiation_statement [
    (simple_name)
    (extended_simple_name)
    (selected_name suffix: [
        (simple_name)
        (extended_simple_name)
    ] @constant @constant.unit.primary .)
] @constant @constant.unit.primary)

(component_instantiation_statement architecture: [
    (simple_name)
    (extended_simple_name)
    (selected_name suffix: [
        (simple_name)
        (extended_simple_name)
    ] @constant @constant.unit.secondary .)
] @constant @constant.unit.secondary)
; }}}
; 11.8 Generate statement {{{
(label [
   (identifier)
   (extended_identifier)
] @label)

(for_generate_statement
   ["for" "end" "generate"] @conditional @keyword.generate)

(for_generate_statement at_end: [
   (simple_name)
   (extended_simple_name)
] @label .)

(if_generate_statement
   ["end" "generate"] @conditional @keyword.generate)

(if_generate
   ["if" "generate"] @conditional @keyword.generate)

(elsif_generate
   ["elsif" "generate"] @conditional @keyword.generate)

(else_generate
   ["else" "generate"] @conditional @keyword.generate)

(if_generate_statement at_end: [
   (simple_name)
   (extended_simple_name)
] @label .)

(case_generate_statement
   (expression [
      (simple_name)
      (extended_simple_name)
      (_ [
         (simple_name)
         (extended_simple_name)
         (_ [
            (simple_name)
            (extended_simple_name) ] @constant.object.constant)
      ] @constant.object.constant)
   ]))

(case_generate_statement
   ["case" "generate" "end" "generate"] @conditional @keyword.generate)

; Assume simple name on case generate statement are constant
(case_generate_statement at_end: [
   (simple_name)
   (extended_simple_name)
] @label .)

(case_generate_alternative
   "when" @conditional @keyword.generate)

(case_generate_alternative
   (choices
     (simple_expression [(simple_name) (extended_simple_name)] @character)))

(generate_statement_body
   ["begin" "end"] @conditional @keyword.generate)

; Assume simple name on if generate condition and case generate expression
; are constant
((simple_name) @constant.object.constant
 (#has-ancestor? @constant.object.constant if_generate elsif_generate case_generate_statement)
 (#not-has-ancestor? @constant.object.constant generate_statement_body ambiguous_name function_call))

((extended_simple_name) @constant.object.constant
 (#has-ancestor? @constant.object.constant if_generate elsif_generate case_generate_statement)
 (#not-has-ancestor? @constant.object.constant generate_statement_body ambiguous_name function_call))

(generate_statement_body at_end: [
   (simple_name)
   (extended_simple_name)
] @label .)
; }}}
; 13.2 Design libraries {{{
(library_clause
   "library" @include)

(logical_name_list library: [
   (simple_name)
   (extended_simple_name)
] @namespace)
; }}}
; 13.3 Context declarations {{{
(context_declaration
   ["context" "is" "end"] @keyword.unit.primary)

(context_declaration [
   (identifier)
   (extended_identifier)
] @constant @context)

(context_declaration at_end: [
   (simple_name)
   (extended_simple_name)
   (selected_name suffix: [
      (simple_name)
      (extended_simple_name)
   ] @constant @context .)
] @constant @context .)

(context_reference
   "context" @keyword.unit.primary)
; }}}
; 15.5.2 Decimal literals {{{
(integer_decimal
   (integer (separator)? @number.separator)) @number

(based_integer
   "#" @number.delimeter) @number

(real_decimal
   (integer (separator)? @float.separator)) @float

(real_decimal
   "." @float.dot)

(based_real
   "#" @float.delimiter) @float

(based_real
   "." @float.delimiter)
; }}}
; 15.6 Character literals {{{
(character_literal
   "'" @character.delimeter) @character
; }}}
; 15.7 String literal {{{
(string_literal
  "\"" @string.delimeter) @string

(escape_sequence) @string.escape
; }}}
; 15.8 Bit string literals {{{
(bit_string_literal
  (base_specifier) @string.delimeter @bit_string.delimeter
  "\""             @string.delimeter @bit_string.delimeter) @string @bit_string

(bit_string_literal
  (length) @bit_string.length)

(bit_value [
   (separator)  @bit_string.separator
   (unresolved) @bit_string.unresolved
   (dont_care)  @bit_string.dont_care
   (illegal)    @error
])

((unresolved) @bit_string.unresolved.std_ulogic
 (#vim-match? @bit_string.unresolved.std_ulogic "[uUxXzZlLhHwW]"))
; }}}
; 15.9 Comments {{{
(comment) @comment

((comment) @annotation
   (#vim-match? @annotation "^\-\- *([pP][rR][aA][gG][mM][aA]|[sS][yY][nN][oO][pP][sS][yY][sS]|[sS][yY][nN][tT][hH][eE][sS][iI][sS])"))
; }}}
; 15.11 Tool directives {{{
(tool_directive) @annotation
; }}}
; PSL
; PSL 5 Boolean layers {{{
((PSL_Identifier) @error @error.illegal.identifier
 (#not-vim-match? @error "^[a-zA-Z](_?[a-zA-Z0-9])*$"))

(PSL_Built_In_Function_Call [
    "prev"
    "next"
    "stable"
    "rose"
    "fell"
    "isunknown"
    "countones"
    "onehot"
    "onehot0"
    "nondet"
    "nondet_vector"
] @function.builtin @function.builtin.psl)

(((simple_name) @constant.macro @constant.psl.builtin
  (#vim-match? @constant.macro "^[iI][nN][fF]$")
  (#has-ancestor? @constant.macro PSL_Count)))

(PSL_Expression
   operator: _ @operator)
; }}}
; PSL 5.3 Union expressions {{{
(PSL_Union_Expression
   operator: _ @operator)
; }}}
; PSL 6.1.1 Sequential Extended Regular Expressions (SEREs) {{{
(PSL_Simple_SERE
   operator: _ @operator)

(PSL_Compound_SERE
   operator: _ @operator)

(PSL_Parameterized_SERE
   "for" @repeat
   operator: _ @operator
   ["{" "}"] @operator)

(PSL_Parameter_Specification
   "in" @repeat)

(PSL_Parameter_Specification
   (PSL_Identifier) @parameter)
; }}}
; PSL 6.1.2 Sequences {{{
(PSL_Count
   operator: _ @operator)

(PSL_Braced_SERE
   ["{" "}"] @operator)

(PSL_Clocked_SERE
   ["{" "}" "@"] @operator)
; }}}
; PSL 6.2.1 FL Properties {{{
(PSL_Parenthesized_FL_Property
   ["(" ")"] @operator)

(PSL_Sequential_FL_Property
   "!" @operator @operator.psl.strong)

(PSL_Clocked_FL_Property
   "@" @operator)

(PSL_Invariant_FL_Property
   operator: _ @operator)

(PSL_Ocurrence_FL_Property
   operator: _ @operator)

(PSL_Implication_FL_Property
   operator: _ @operator)

(PSL_Logical_FL_Property
   operator: _ @operator)

(PSL_Factor_FL_Property
   operator: _ @operator)

(PSL_Extended_Ocurrence_FL_Property
   operator: _ @operator)

(PSL_Extended_Ocurrence_FL_Property
   ["(" ")"] @operator)

(PSL_Termination_FL_Property
   operator: _ @operator)

(PSL_Bounding_FL_Property
   operator: _ @operator)

(PSL_Bounding_FL_Property [
   "!" @operator @operator.psl.strong
   "_" @operator @operator.psl.weak
])

(PSL_Suffix_Implication_FL_Property
   operator: _ @operator)

(PSL_Suffix_Implication_FL_Property
   ["{" "}" "(" ")"] @operator)

(PSL_Parameterized_Property
   operator: _ @operator)

(PSL_Parameterized_Property
   ["for" "(" ")"] @repeat)
; }}}
; PSL 6.2.3 Replicated properties {{{
(PSL_Property_Replicator
  "forall"  @repeat)

(PSL_Value_Set
   ["{" "}"] @repeat)

(PSL_Value_Set
   (boolean) @type)
; }}}
; PSL 6.3 Property and sequence declarations {{{
(PSL_Property_Declaration
   (PSL_Identifier) @psl.property)

(PSL_Sequence_Declaration
   (PSL_Identifier) @psl.sequence)

(PSL_Constant_Parameter_Specification
   "const" @keyword)

(PSL_HDL_Type
   "hdltype" @keyword)

(PSL_Type_Class) @type
; }}}
; PSL 6.3.3 Instantiation {{{
(PSL_Sequence_Instance
   (PSL_Identifier) @psl.sequence)

(PSL_Property_Instance
   (PSL_Identifier) @psl.property)
; }}}
; PSL 7.2 Verification units {{{
[
   "vunit"
   "vprop"
   "vmode"
] @keyword.unit.primary

(PSL_VUnit
  (PSL_Identifier) @constant @constant.unit.primary)

(PSL_VProp
  (PSL_Identifier) @constant @constant.unit.primary)

(PSL_VMode
  (PSL_Identifier) @constant @constant.unit.primary)

((ambiguous_name
   (simple_name) @function @subprogram.function) @_c
   (#vim-match? @function "^\%([pP][rR][eE][vV]|[nN][eE][xX][tT]|[sS][tT][aA][bL][eE]|[rR][oO][sS][eE]|[fF][eE][lL][lL]|[iI][sS][uU][nN][kK][nN][oO][wW][nN]|[cC][oO][uU][nN][oO][nN][eE][sS]|[oO][nN][eE][hH][oO][tT]0?|[nN][oO][nN][dD][eE][tT]\%(_[vV][eE][cC][tT][oO][rR]\)?\)$")
   (#has-ancestor? @_c PSL_VUnit PSL_VProp PSL_VMode))

(PSL_Hierarchical_HDL_Name entity: [
      (simple_name)
      (extended_simple_name)
      (selected_name suffix: [
         (simple_name)
         (extended_simple_name)
      ] @constant @constant.unit.primary .)
] @constant @constant.unit.primary )

(PSL_Hierarchical_HDL_Name instance: [
      (simple_name)
      (extended_simple_name)
      (selected_name suffix: [
         (simple_name)
         (extended_simple_name)
      ] @constant @constant.unit.secondary .)
] @constant @constant.unit.secondary )

(PSL_Inherit_Spec
   "inherit" @include)
; }}}
; Reserved words on identifiers
; Verilog, PSL and VHDL reserved words {{{
; Verilog Reserved words
([(identifier) (simple_name)] @warning @warning.verilog.keyword
 (#vim-match? @warning "^\%([aA]\%([lL][wW][aA][yY][sS]|[sS][sS][iI][gG][nN]\)|[bB][uU][fF]\%([iI][fF][01]\)?|[cC]\%([aA][sS][eE][[xX][zZ]]|[eE][lL][lL]|[mM][oO][sS]|[oO][nN][fF][iI][gG]\)|[dD]\%([eE]\%([aA][sS][sS][iI][gG][nN]|[fF][pP][aA][rR][aA][mM]|[sS][iI][gG][nN]\)|[iI][sS][aA][bB][lL][eE]\)|[eE]\%([dD][gG][eE]|[nN][dD]\%([cC]\%([aA][sS][eE]|[oO][nN][fF][iI][gG]\)|[fF][uU][nN][cC][tT][iI][oO][nN]|[gG][eE][nN][eE][rR][aA][tT][eE]|[mM][oO][dD][uU][lL][eE]|[pP][rR][iI][mM][iI][tT][iI][vV][eE]|[sS][pP][eE][cC][iI][fF][yY]|[tT][aA]\%([bB][lL][eE]|[sS][kK]\)\)|[vV][eE][nN][tT]\)|[fF][oO][rR]\%([cC][eE]|[eE][vV][eE][rR]|[kK]\)|[gG][eE][nN][vV][aA][rR]|[hH][iI][gG][hH][zZ][01]|[iI]\%([fF][nN][oO][nN][eE]|[nN]\%([cC]\%([dD][iI][rR]|[lL][uU][dD][eE]\)|[iI][tT][iI][aA][lL]|[pP][uU][tT]|[sS][tT][aA][nN][cC][eE]\)\)|[jJ][oO][iI][nN]|[lL]\%([aA][rR][gG][eE]|[iI][bB][lL][iI][sS][tT]|[oO][cC][aA][lL][pP][aA][rR][aA][mM]\)|[mM]\%([aA][cC][rR][oO][mM][oO][dD][uU][lL][eE]|[eE][dD][iI][uU][mM]|[oO][dD][uU][lL][eE]\)|[nN]\%([eE][gG][eE][dD][gG][eE]|[mM][oO][sS]|[oO]\%([sS][hH][oO][wW][cC][aA][nN][cC][eE][lL][lL][eE][dD]|[tT][iI][fF][01]\)\)|[oO][uU][tT][pP][uU][tT]|[pP]\%([mM][oO][sS]|[oO][sS][eE][dD][gG][eE]|[rR][iI][mM][iI][tT][iI][vV][eE]|[uU][lL]\%([lL]\%([01]|[dD][oO][wW][nN]|[uU][pP]\)|[sS][eE][sS][tT][yY][lL][eE]_[oO][nN]\%([dD][eE][tT][eE][cC][tT]|[eE][vV][eE][nN][tT]\)\)\)|[rR]\%([cC][mM][oO][sS]|[eE]\%([aA][lL][tT][iI][mM][eE]|[gG]|[pP][eE][aA][tT]\)|[nN][mM][oO][sS]|[pP][mM][oO][sS]|[tT][rR][aA][nN]\%([iI][fF][01]\)?\)|[sS]\%([cC][aA][lL][aA][rR][eE][dD]|[hH][oO][wW][cC][aA][nN][cC][eE][lL][lL][eE][dD]|[mM][aA][lL][lL]|[pP][eE][cC]\%([iI][fF][yY]|[pP][aA][rR][aA][mM]\)|[tT][rR]\%([eE][nN][gG][tT][hH]|[oO][nN][gG][01]\)|[uU][pP][pP][lL][yY][01]\)|[tT]\%([aA]\%([bB][lL][eE]|[sS][kK]\)|[rR]\%([aA][nN]\%([iI][fF][01]\)?|[iI]\%(\%([01]|[aA][nN][dD]|[oO][rR]|[rR][eE][gG]\)\)?\)\)|[vV][eE][cC][tT][oO][rR][eE][dD]|[wW]\%([aA][nN][dD]|[eE][aA][kK][01]|[iI][rR][eE]|[oO][rR]\)\)$"))

; PSL Reserved words
([(identifier) (simple_name)] @warning @warning.psl.keyword
(#vim-match? @warning "^\%([aA]\%([bB][oO][rR][tT]|[lL][wW][aA][yY][sS]|[sS]\%([sS]\%([eE][rR][tT]|[uU][mM][eE]\%(_[gG][uU][aA][rR][aA][nN][tT][eE][eE]\)?\)|[yY][nN][cC]_[aA][bB][oO][rR][tT]\)\)|[bB]\%([eE][fF][oO][rR][eE]_?|[oO][oO][lL][eE][aA][nN]\)|[cC]\%([lL][oO][cC][kK]|[oO]\%([nN][sS][tT]|[uU][nN][tT][oO][nN][eE][sS]|[vV][eE][rR]\)\)|[dD][eE][fF][aA][uU][lL][tT]|[eE][nN][dD][eE][dD]|[fF]\%([aA][iI][rR][nN][eE][sS][sS]|[eE][lL][lL]|[oO][rR][aA][lL][lL]\)|[hH][dD][lL][tT][yY][pP][eE]|[iI]\%([nN]\%([fF]|[hH][eE][rR][iI][tT]\)|[sS][uU][nN][kK][nN][oO][wW][nN]\)|[nN]\%([eE]\%([vV][eE][rR]|[xX][tT]\%(_\%([aA]|[eE]\%([vV][eE][nN][tT]\%(_[[aA][eE]]\)?\)?\)\)?\)|[oO][nN][dD][eE][tT]\%(_[vV][eE][cC][tT][oO][rR]\)?\)|[oO][nN][eE][hH][oO][tT]0?|[pP][rR]\%([eE][vV]|[oO][pP][eE][rR][tT][yY]\)|[rR]\%([eE]\%([pP][oO][rR][tT]|[sS][tT][rR][iI][cC][tT]\%(_[gG][uU][aA][rR][aA][nN][tT][eE][eE]\)?\)|[oO][sS][eE]\)|[sS]\%([eE][qQ][uU][eE][nN][cC][eE]|[tT]\%([aA][bB][lL][eE]|[rR][oO][nN][gG]\)|[yY][nN][cC]_[aA][bB][oO][rR][tT]\)|[uU][nN]\%([iI][oO][nN]|[tT][iI][lL]_?\)|[vV]\%([mM][oO][dD][eE]|[pP][rR][oO][pP]|[uU][nN][iI][tT]\)|[wW][iI][tT][hH][iI][nN]\)$"))

; VHDL Reserved words
([(identifier) (simple_name)] @keyword @warning @warning.unexpected.keyword
 (#vim-match? @keyword "^\%([aA]\%([bB][sS]|[cC][cC][eE][sS][sS]|[fF][tT][eE][rR]|[lL]\%([iI][aA][sS]|[lL]\)|[nN][dD]|[rR]\%([cC][hH][iI][tT][eE][cC][tT][uU][rR][eE]|[rR][aA][yY]\)|[sS][sS]\%([eE][rR][tT]|[uU][mM][eE]\%(_[gG][uU][aA][rR][aA][nN][tT][eE][eE]\)?\)|[tT][tT][rR][iI][bB][uU][tT][eE]\)|[bB]\%([eE][gG][iI][nN]|[lL][oO][cC][kK]|[oO][dD][yY]|[uU]\%([fF][fF][eE][rR]|[sS]\)\)|[cC]\%([aA][sS][eE]|[oO]\%([mM][pP][oO][nN][eE][nN][tT]|[nN]\%([fF][iI][gG][uU][rR][aA][tT][iI][oO][nN]|[sS][tT][aA][nN][tT]|[tT][eE][xX][tT]\)|[vV][eE][rR]\)\)|[dD]\%([eE][fF][aA][uU][lL][tT]|[iI][sS][cC][oO][nN][nN][eE][cC][tT]|[oO][wW][nN][tT][oO]\)|[eE]\%([lL][sS]\%([eE]|[iI][fF]\)|[nN]\%([dD]|[tT][iI][tT][yY]\)|[xX][iI][tT]\)|[fF]\%([aA][iI][rR][nN][eE][sS][sS]|[iI][lL][eE]|[oO][rR]\%([cC][eE]\)?|[uU][nN][cC][tT][iI][oO][nN]\)|[gG]\%([eE][nN][eE][rR]\%([aA][tT][eE]|[iI][cC]\)|[rR][oO][uU][pP]|[uU][aA][rR][dD][eE][dD]\)|[iI]\%([[fF][sS]]|[mM][pP][uU][rR][eE]|[nN]\%(\%([eE][rR][tT][iI][aA][lL]|[oO][uU][tT]\)\)?\)|[lL]\%([aA][bB][eE][lL]|[iI]\%([bB][rR][aA][rR][yY]|[nN][kK][aA][gG][eE]|[tT][eE][rR][aA][lL]\)|[oO][oO][pP]\)|[mM]\%([aA][pP]|[oO][dD]\)|[nN]\%([aA][nN][dD]|[eE]\%([wW]|[xX][tT]\)|[oO][[rR][tT]]|[uU][lL][lL]\)|[oO]\%([[fF][nN][rR]]|[pP][eE][nN]|[tT][hH][eE][rR][sS]|[uU][tT]\)|[pP]\%([aA]\%([cC][kK][aA][gG][eE]|[rR][aA][mM][eE][tT][eE][rR]\)|[oO]\%([rR][tT]|[sS][tT][pP][oO][nN][eE][dD]\)|[rR][oO]\%([cC][eE]\%([dD][uU][rR][eE]|[sS][sS]\)|[pP][eE][rR][tT][yY]|[tT][eE][cC][tT][eE][dD]\)|[uU][rR][eE]\)|[rR]\%([aA][nN][gG][eE]|[eE]\%([cC][oO][rR][dD]|[gG][iI][sS][tT][eE][rR]|[jJ][eE][cC][tT]|[lL][eE][aA][sS][eE]|[mM]|[pP][oO][rR][tT]|[sS][tT][rR][iI][cC][tT]\%(_[gG][uU][aA][rR][aA][nN][tT][eE][eE]\)?|[tT][uU][rR][nN]\)|[oO][lL]\)|[sS]\%([eE]\%([lL][eE][cC][tT]|[qQ][uU][eE][nN][cC][eE]|[vV][eE][rR][iI][tT][yY]\)|[hH][aA][rR][eE][dD]|[iI][gG][nN][aA][lL]|[lL][[aA][lL]]|[rR][[aA][lL]]|[tT][rR][oO][nN][gG]|[uU][bB][tT][yY][pP][eE]\)|[tT]\%([hH][eE][nN]|[oO]|[rR][aA][nN][sS][pP][oO][rR][tT]|[yY][pP][eE]\)|[uU]\%([nN]\%([aA][fF][fF][eE][cC][tT][eE][dD]|[iI][tT][sS]|[tT][iI][lL]\)|[sS][eE]\)|[vV]\%([aA][rR][iI][aA][bB][lL][eE]|[mM][oO][dD][eE]|[pP][rR][oO][pP]|[uU][nN][iI][tT]\)|[wW]\%([aA][iI][tT]|[hH]\%([eE][nN]|[iI][lL][eE]\)|[iI][tT][hH]\)|[xX]\%([nN][oO][rR]|[oO][rR]\)\)$"))
; }}}
; Named constants {{{
((simple_name) @boolean @boolean.true
   (#vim-match? @boolean "^[tT][rR][uU][eE]$"))

((simple_name) @boolean @boolean.false
   (#vim-match? @boolean "^[fF][aA][lL][sS][eE]$"))

((simple_name) @constant.builtin @constant.severity @constant.severity.note
   (#vim-match? @constant.builtin "^[nN][oO][tT][eE]$"))

((simple_name) @constant.builtin @constant.severity @constant.severity.warning
   (#vim-match? @constant.builtin "^[wW][aA][rR][nN][iI][nN][gG]$"))

((simple_name) @constant.builtin @constant.severity @constant.severity.error
   (#vim-match? @constant.builtin "^[eE][rR][rR][oO][rR]$"))

((simple_name) @constant.builtin @constant.severity @constant.severity.failure
   (#vim-match? @constant.builtin "^[fF][aA][iI][lL][uU][rR][eE]$"))
; }}}
; ERRORS
; 3.2 Entity declarations {{{
(entity_declaration
   (header [
      (generic_clause     ")" @error @error.missing.semicolon .)
      (generic_map_aspect ")" @error @error.missing.semicolon .)
      (port_clause        ")" @error @error.missing.semicolon .)
      (port_map_aspect    ")" @error @error.missing.semicolon .)

      (generic_map_aspect [(any) (default)] @error)

      (generic_map_aspect ["generic" "map"] @error) @error.region
      (port_map_aspect    ["port"    "map"] @error) @error.region
   ]))

((entity_declaration
         . [(identifier)  (extended_identifier)]  @_h @error @error.repeated.name
   at_end: [(simple_name) (extended_simple_name)] @_t @error @error.repeated.name .)
           (#not-eq? @_h @_t))
; }}}
; 3.3 Architecture bodies {{{
((architecture_body
         . [(identifier)  (extended_identifier)]  @_h @error @error.repeated.name
   at_end: [(simple_name) (extended_simple_name)] @_t @error @error.repeated.name .)
           (#not-eq? @_h @_t))
; }}}
; 3.4 Configuration declarations {{{
((configuration_declaration
         . [(identifier)  (extended_identifier)]  @_h @error @error.repeated.name
   at_end: [(simple_name) (extended_simple_name)] @_t @error @error.repeated.name .)
           (#not-eq? @_h @_t))
; }}}
; 4.2.1 Subprogram declarations {{{
(subprogram_header [
   (generic_clause     (semicolon) @error @error.unexpected.semicolon)
   (generic_map_aspect (semicolon) @error @error.unexpected.semicolon)
   (port_clause        (semicolon) @error @error.unexpected.semicolon)
   (port_map_aspect    (semicolon) @error @error.unexpected.semicolon)

   (generic_map_aspect [(any) (default)] @error)

   (port_clause      "port"        @error) @error.region
   (port_map_aspect ["port" "map"] @error) @error.region
])

;; Procedure declaration {{{
(procedure_declaration ["pure" "impure"] @error)

(procedure_declaration
   (return "return" @error @error.unexpected.return) @error.region)

(procedure_parameter_clause [
   (signal_interface_declaration  (mode ["buffer" "linkage"])   @error) @error.region
   (signal_interface_declaration  (default_expression)          @error) @error.region
   (type_interface_declaration      "type"                      @error) @error.region
   (package_interface_declaration   "package"                   @error) @error.region
   (procedure_interface_declaration "procedure"                 @error) @error.region
   (function_interface_declaration  ["pure" "impure""function"] @error) @error.region
])
;; }}}
;; Function declaration {{{
(function_parameter_clause [
   (signal_interface_declaration  (mode ["out" "inout" "buffer" "linkage"]) @error)
   (signal_interface_declaration  (default_expression)          @error)
   (variable_interface_declaration  "variable"                  @error)
   (type_interface_declaration      "type"                      @error)
   (package_interface_declaration   "package"                   @error)
   (procedure_interface_declaration "procedure"                 @error)
   (function_interface_declaration  ["pure" "impure""function"] @error)
] @error.region)
;; }}}
; }}}
; 4.3 Subprogram bodies {{{
;; Procedure body
(procedure_body ["pure" "impure" "function"] @error)

(procedure_body
   (return "return" @error @error.unexpected.return) @error.region)

(procedure_body
         . [(identifier)  (extended_identifier)  (operator_symbol)] @_h @error @error.repeated.name
   at_end: [(simple_name) (extended_simple_name) (operator_symbol)] @_t @error @error.repeated.name
   (#not-eq? @_h @_t))
;; Function body
(function_body "procedure" @error) @error.region

(function_body
         . [(identifier)  (extended_identifier)  (operator_symbol)] @_h @error @error.repeated.name
   at_end: [(simple_name) (extended_simple_name) (operator_symbol)] @_t @error @error.repeated.name
   (#not-eq? @_h @_t))
; }}}
; 4.4 Subprogram instantiation declarations {{{
;; Procedure instantiation declarations
(procedure_instantiation_declaration
   ["pure" "impure"] @error)

(procedure_instantiation_declaration
   (signature
      (return "return" @error @error.unexpected.return)) @error.region)

;; Function instantiation declarations
(function_instantiation_declaration
   (signature
      (type_mark) . "]" @error @error.missing.return .) @error.region)

;; Shared
(instantiation_declaration_map_aspect  [
   (generic_clause     (semicolon) @error @error.unexpected.semicolon)
   (generic_map_aspect (semicolon) @error @error.unexpected.semicolon)
   (port_clause        (semicolon) @error @error.unexpected.semicolon)
   (port_map_aspect    (semicolon) @error @error.unexpected.semicolon)
   
   (generic_map_aspect [(any) (default)] @error)

   (port_map_aspect ["port" "map"] @error) @error.region
])
; }}}
; 4.5.3 Signatures {{{
(return
   "," @error @error.unexpected.coma)
; }}}
; 4.7 Package declarations {{{
(package_declaration
   (header [
      (generic_clause     (semicolon) @error @error.unexpected.semicolon)
      (port_clause        (semicolon) @error @error.unexpected.semicolon)

      (generic_map_aspect ")" @error @error.missing.semicolon .)
      (port_map_aspect    ")" @error @error.missing.semicolon .)

      (generic_map_aspect [(any) (default)] @error)

      (port_clause      "port"        @error) @error.region
      (port_map_aspect ["port" "map"] @error) @error.region
   ]))

((package_declaration
         . [(identifier)  (extended_identifier)]  @_h @error @error.repeated.name
   at_end: [(simple_name) (extended_simple_name)] @_t @error @error.repeated.name .)
           (#not-eq? @_h @_t))
; }}}
; 4.8 Package bodies {{{
((package_body
         . [(simple_name) (extended_simple_name)] @_h @error @error.repeated.name
   at_end: [(simple_name) (extended_simple_name)] @_t @error @error.repeated.name .)
           (#not-eq? @_h @_t))
; }}}
; 4.9 Package instantiation declarations {{{
(package_instantiation_declaration
   (instantiation_declaration_map_aspect [
      (generic_clause     (semicolon) @error @error.unexpected.semicolon)
      (generic_map_aspect (semicolon) @error @error.unexpected.semicolon)
      (port_clause        (semicolon) @error @error.unexpected.semicolon)
      (port_map_aspect    (semicolon) @error @error.unexpected.semicolon)

      (generic_map_aspect [(any) (default)] @error)

      (port_map_aspect ["port" "map"] @error) @error.region
   ]))
; }}}
; 5.2.4 Physical types {{{
((full_type_declaration
   [(identifier) (extended_identifier)] @_h @error @error.repeated.name
   (physical_type_definition
      at_end: [(simple_name) (extended_simple_name)] @_t @error @error.repeated.name .))
   (#not-eq? @_h @_t))
; }}}
; 5.3.3 Record types {{{
((full_type_declaration
   [(identifier) (extended_identifier)] @_h @error @error.repeated.name
   (record_type_definition
      at_end: [(simple_name) (extended_simple_name)] @_t @error @error.repeated.name .))
   (#not-eq? @_h @_t))
; }}}
; 5.4.3 Allocation and deallocation of objects {{{
; deallocate shall not have named association element
(procedure_call_statement
   procedure: (simple_name) @function.builtin @subprogram.procedure.builtin
              (association_list
                    (named_association_element) @error)
              (#match? @function.builtin "^[dD][eE][aA][lL][lL][oO][cC][aA][tT][eE]$")) @error.region

; deallocate shall have a single argument
(procedure_call_statement
   procedure: (simple_name) @function.builtin @subprogram.procedure.builtin
              (association_list
                    (positional_association_element)
                  . (positional_association_element) @error)
              (#match? @function.builtin "^[dD][eE][aA][lL][lL][oO][cC][aA][tT][eE]$")) @error.region
; }}}
; 5.6.2 Protected type declarations {{{
((full_type_declaration
   [(identifier) (extended_identifier)] @_h @error @error.repeated.name
   (protected_type_declaration
      at_end: [(simple_name) (extended_simple_name)] @_t @error @error.repeated.name .))
   (#not-eq? @_h @_t))
; }}}
; 5.6.3 Protected type bodies {{{
((full_type_declaration
   [(identifier) (extended_identifier)] @_h @error @error.repeated.name
   (protected_type_body
      at_end: [(simple_name) (extended_simple_name)] @_t @error @error.repeated.name .))
   (#not-eq? @_h @_t))
; }}}
; 6.0 Declarations {{{
(entity_declaration
   (declarative_part [
      (variable_declaration)
      (component_declaration)
      (configuration_specification)
   ] @error.unexpected.declaration))

(architecture_body
   (declarative_part [
      (variable_declaration)
   ] @error.unexpected.declaration))

(configuration_declaration
   (declarative_part [
      (procedure_declaration)
      (function_declaration)
      (procedure_body)
      (function_body)
      (procedure_instantiation_declaration)
      (function_instantiation_declaration)
      (package_declaration)
      (package_body)
      (package_instantiation_declaration)
      (full_type_declaration)
      (incomplete_type_declaration)
      (subtype_declaration)
      (constant_declaration)
      (signal_declaration)
      (variable_declaration)
      (shared_variable_declaration)
      (file_declaration)
      (alias_declaration)
      (component_declaration)
      (attribute_declaration)
      (attribute_specification)
      (configuration_specification)
      (group_template_declaration)
      (disconnection_specification)
      (PSL_Assert_Directive)
      (PSL_Assume_Directive)
      (PSL_Assume_Guarantee_Directive)
      (PSL_Restrict_Directive)
      (PSL_Restrict_Guarantee_Directive)
      (PSL_Cover_Directive)
      (PSL_Fairness_Directive)
      (PSL_Strong_Fairness_Directive)
      (PSL_Property_Declaration)
      (PSL_Sequence_Declaration)
      (PSL_Clock_Declaration)
   ] @error.unexpected.declaration))

(procedure_body
   (declarative_part [
      (signal_declaration)
      (shared_variable_declaration)
      (component_declaration)
      (configuration_specification)
      (PSL_Assert_Directive)
      (PSL_Assume_Directive)
      (PSL_Assume_Guarantee_Directive)
      (PSL_Restrict_Directive)
      (PSL_Restrict_Guarantee_Directive)
      (PSL_Cover_Directive)
      (PSL_Fairness_Directive)
      (PSL_Strong_Fairness_Directive)
      (PSL_Property_Declaration)
      (PSL_Sequence_Declaration)
      (PSL_Clock_Declaration)
   ] @error.unexpected.declaration))

(function_body
   (declarative_part [
      (signal_declaration)
      (shared_variable_declaration)
      (component_declaration)
      (configuration_specification)
      (PSL_Assert_Directive)
      (PSL_Assume_Directive)
      (PSL_Assume_Guarantee_Directive)
      (PSL_Restrict_Directive)
      (PSL_Restrict_Guarantee_Directive)
      (PSL_Cover_Directive)
      (PSL_Fairness_Directive)
      (PSL_Strong_Fairness_Directive)
      (PSL_Property_Declaration)
      (PSL_Sequence_Declaration)
      (PSL_Clock_Declaration)
   ] @error.unexpected.declaration))

(package_declaration
   (declarative_part [
      (package_body)
      (shared_variable_declaration)
      (configuration_specification)
   ] @error.unexpected.declaration))

(package_body
   (declarative_part [
      (procedure_body)
      (function_body)
      (package_body)
      (shared_variable_declaration)
      (configuration_specification)
      (PSL_Assert_Directive)
      (PSL_Assume_Directive)
      (PSL_Assume_Guarantee_Directive)
      (PSL_Restrict_Directive)
      (PSL_Restrict_Guarantee_Directive)
      (PSL_Cover_Directive)
      (PSL_Fairness_Directive)
      (PSL_Strong_Fairness_Directive)
   ] @error.unexpected.declaration))

(protected_type_declaration
   (declarative_part [
      (procedure_body)
      (function_body)
      (package_declaration)
      (package_body)
      (package_instantiation_declaration)
      (full_type_declaration)
      (incomplete_type_declaration)
      (subtype_declaration)
      (constant_declaration)
      (signal_declaration)
      (variable_declaration)
      (shared_variable_declaration)
      (file_declaration)
      (alias_declaration)
      (component_declaration)
      (attribute_declaration)
      (configuration_specification)
      (disconnection_specification)
      (group_template_declaration)
      (group_declaration)
      (PSL_Assert_Directive)
      (PSL_Assume_Directive)
      (PSL_Assume_Guarantee_Directive)
      (PSL_Restrict_Directive)
      (PSL_Restrict_Guarantee_Directive)
      (PSL_Cover_Directive)
      (PSL_Fairness_Directive)
      (PSL_Strong_Fairness_Directive)
      (PSL_Property_Declaration)
      (PSL_Sequence_Declaration)
   ] @error.unexpected.declaration))

(protected_type_body
   (declarative_part [
      (signal_declaration)
      (shared_variable_declaration)
      (component_declaration)
      (configuration_specification)
      (disconnection_specification)
      (PSL_Assert_Directive)
      (PSL_Assume_Directive)
      (PSL_Assume_Guarantee_Directive)
      (PSL_Restrict_Directive)
      (PSL_Restrict_Guarantee_Directive)
      (PSL_Cover_Directive)
      (PSL_Fairness_Directive)
      (PSL_Strong_Fairness_Directive)
      (PSL_Property_Declaration)
      (PSL_Sequence_Declaration)
   ] @error.unexpected.declaration))

(block_statement
   (declarative_part
      (shared_variable_declaration) @error.unexpected.declaration))

(process_statement
   (declarative_part [
      (signal_declaration)
      (shared_variable_declaration)
      (component_declaration)
      (configuration_specification)
      (disconnection_specification)
      (PSL_Assert_Directive)
      (PSL_Assume_Directive)
      (PSL_Assume_Guarantee_Directive)
      (PSL_Restrict_Directive)
      (PSL_Restrict_Guarantee_Directive)
      (PSL_Cover_Directive)
      (PSL_Fairness_Directive)
      (PSL_Strong_Fairness_Directive)
      (PSL_Property_Declaration)
      (PSL_Sequence_Declaration)
      (PSL_Clock_Declaration)
   ] @error.unexpected.declaration))
; }}}
; 6.4.2 Object declarations {{{
;; Constant
(constant_interface_declaration
   (mode ["out" "inout" "buffer" "linkage"] @error)
   (default_expression)? @error) @error.region

;; Signal
(signal_interface_declaration
   (signal_kind "register" @error)) @error.region

;; Variable
(variable_interface_declaration
  (mode ["buffer" "linkage"] @error)) @error.region

(variable_interface_declaration
   (mode ["out" "inout" "buffer" "linkage"])
   (default_expression) @error) @error.region

;; File
(file_interface_declaration
   (mode _ @error)) @error.region
; }}}
; 6.5.4 Interface subprogram declarations {{{
(procedure_interface_declaration
   (interface_subprogram_default
      (_ ["generic" "port" "map" ] @error))? @error.region)

(procedure_declaration
   (return "return" @error @error.unexpected.return) @error.region)

(function_interface_declaration
   (interface_subprogram_default
      (_ ["generic" "port" "map" ] @error))? @error.region)
; }}}
; 6.5.5 Interface package declarations {{{
(package_interface_declaration
   (map_aspect [
      (generic_clause     (semicolon) @error @error.unexpected.semicolon)
      (generic_map_aspect (semicolon) @error @error.unexpected.semicolon)
      (port_clause        (semicolon) @error @error.unexpected.semicolon)
      (port_map_aspect    (semicolon) @error @error.unexpected.semicolon)

      (port_map_aspect ["port" "map"] @error) @error.region
   ])
)
; }}}
; 6.5.6.2 Generic clauses {{{
(generic_clause [
   (signal_interface_declaration   "signal"   @error)
   (variable_interface_declaration "variable" @error)
   (file_interface_declaration     "file"     @error)
] @error.region)
; }}}
; 6.5.6.3 Port clauses {{{
(port_clause [
   (constant_interface_declaration   "constant"                 @error)
   (variable_interface_declaration   "variable"                 @error)
   (file_interface_declaration       "file"                     @error)
   (type_interface_declaration       "type"                     @error)
   (package_interface_declaration    "package"                  @error)
   (procedure_interface_declaration "procedure"                 @error)
   (function_interface_declaration  ["pure" "impure""function"] @error)
] @error.region)
;; }}}
; 6.5.7 Association lists {{{
(association_list
   (named_association_element)
 . ("," (positional_association_element) @error @error.association.order)+)

; others not allowed
(association_list
   (named_association_element
      formal_part: (others) @error @error.association.illegal) @error.region)
; }}}
; HEADERS AND MAP ASPECT {{{
(header [
   ((generic_map_aspect) (generic_map_aspect ["generic" "map"] @error) @error.region)
   ((port_map_aspect)    (generic_map_aspect ["generic" "map"] @error) @error.region)
   ((port_clause)        (generic_map_aspect ["generic" "map"] @error) @error.region)
   ((port_clause)        (generic_clause      "generic"        @error) @error.region)
   ((generic_clause)     (generic_clause      "generic"        @error) @error.region)
   ((port_map_aspect)    (generic_clause      "generic"        @error) @error.region)
   ((generic_map_aspect) (generic_clause      "generic"        @error) @error.region)
   ((generic_clause)     (port_map_aspect    ["port"    "map"] @error) @error.region)
   ((port_map_aspect)    (port_map_aspect    ["port"    "map"] @error) @error.region)
   ((port_clause)        (port_clause         "port"           @error) @error.region)
   ((port_map_aspect)    (port_clause         "port"           @error) @error.region)
])

(map_aspect [
   (generic_clause "generic" @error) @error.region
   (port_clause    "port"    @error) @error.region
])
; }}}
; 6.8 Component declarations {{{
(component_declaration 
   (header [
      (generic_clause     ")" @error @error.missing.semicolon .)
      (generic_map_aspect ")" @error @error.missing.semicolon .)
      (port_clause        ")" @error @error.missing.semicolon .)
      (port_map_aspect    ")" @error @error.missing.semicolon .)

      (generic_map_aspect [(any) (default)] @error)

      (generic_map_aspect ["generic" "map"] @error) @error.region
      (port_map_aspect    ["port"    "map"] @error) @error.region
   ]))

((component_declaration
         . [(identifier) (extended_identifier)]  @_h @error @error.repeated.name
   at_end: [(simple_name) (extended_simple_name)] @_t @error @error.repeated.name .)
           (#not-eq? @_h @_t))
; }}}
; 8.3.2 Binding indication {{{
(binding_indication
   (map_aspect [
      (generic_clause     (semicolon) @error @error.unexpected.semicolon)
      (generic_map_aspect (semicolon) @error @error.unexpected.semicolon)
      (port_clause        (semicolon) @error @error.unexpected.semicolon)
      (port_map_aspect    (semicolon) @error @error.unexpected.semicolon)

      (generic_map_aspect [(any) (default)] @error)
   ]))

(binding_indication
   (entity_aspect (open))
   (map_aspect [
      (generic_map_aspect ["generic" "map"] @error)
      (port_map_aspect    ["port"    "map"] @error)
   ] @error.region)
)
; }}}
; 8.6 Attribute names {{{
;; Base attribute is allowed only as prefix of another attribute
((attribute_name
      prefix: [(simple_name) (extended_simple_name)] @type
  designator: (predefined_designator "base") @error) @error.region
 (#not-has-parent? @error.region attribute_name))

;; attributes that always expects an expressions
(attribute_name
  designator: (predefined_designator [
    "image"
    "value"
    "pos"
    "val"
    "succ"
    "pred"
    "leftof"
    "rightof"
    "left"
    "right"
    "high"
    "low"
    "length"
    "ascending"
    "delayed"
    "stable"
    "quiet" ]) @error @error.missing.expression .) @error.region

; unexpected expression
(function_call
   function: (attribute_name
      designator: (predefined_designator))
   ["(" (association_list) ")"] @error @error.unexpected.expression) @error.region
; }}}
; 9. Expressions {{{
;; Logical expression associativity error
((logical_expression
       left: (logical_expression operator: _ @_l)
   operator: _ @_op @error @error.expression.associativity) @error.region
            (#not-eq? @_l @_op))

(logical_expression
       left: (logical_expression operator: ["nand" "nor"])
   operator: _ @error @error.expression.associativity) @error.region

;; Precedence
((reduction ["and" "or" "xor" "nand" "nor" "xnor"] @error @error.expression.precedence) @error.region
 (#not-has-parent? @error.region condition expression))

((condition ["??"] @error @error.expression.precedence) @error.region
 (#not-has-parent? @error.region condition expression))

((sign ["+" "-"] @error @error.expression.precedence) @error.region
 (#has-ancestor? @error.region term factor exponentiation))

;; Named expressions
(condition [
   (shift_expression)
   (concatenation)
   (concatenation)
   (simple_expression)
   (sign)
   (term)
   (factor operator: "abs")
   (exponentiation)
] @error @error.region)

(simple_expression [
   (condition)
   (logical_expression)
   (relation)
   (concatenation)
   (factor operator: "not")
   (reduction)
] @error @error.region)

(time_expression [
   (condition)
   (logical_expression)
   (relation)
   (concatenation)
   (factor operator: "not")
   (reduction)
] @error @error.region)

(string_expression [
   (condition)
   (logical_expression)
   (relation)
   (shift_expression)
   (simple_expression)
   (sign)
   (term)
   (factor)
   (exponentiation)
] @error @error.region)
; }}}
; 9.3.3 Aggregates {{{
(aggregate
   (named_element_association)
 . ("," (positional_element_association) @error @error.aggregate.association.order)+) @error.region

; others shall only appear as the last element
(aggregate
   (named_element_association
      (choices (others))) @error @error.aggregate.association.order . (_)) @error.region

(choices
   ((_) @error "|")* . (others) . ("|" (_) @error)*)
; }}}
; 10.5 Signal assignments {{{
(signal_assignment_statement
   target: (aggregate (named_element_association "=>") @error) @error.region)
; }}}
; 10.6 Variable assignments {{{
(variable_assignment_statement
   target: (aggregate
               (named_element_association "=>") @error) @error.region)
; }}}
; 10.8 If statement {{{
((if_statement
         . (label [(identifier) (extended_identifier)] @_h @error @error.repeated.name)
   at_end: [(simple_name) (extended_simple_name)] @_t @error @error.repeated.name .)
           (#not-eq? @_h @_t))
; }}}
; 10.9 Case statement {{{
((case_statement
         . (label [(identifier) (extended_identifier)] @_h @error @error.repeated.name)
   at_end: [(simple_name) (extended_simple_name)] @_t @error @error.repeated.name .)
           (#not-eq? @_h @_t))
; }}}
; 10.10 Loop statement {{{
(loop_statement
 . "loop" @warning @warning.loop.missing.statement
 . "end"  @warning @warning.loop.missing.statement
   "loop" @warning @warning.loop.missing.statement .)
; }}}
; 10.11 Next statement {{{
(((next_statement "next" @_c @error))
  (#not-has-ancestor? @_c loop_statement))
; }}}
; 10.12 Exit statement {{{
(((exit_statement "exit" @_c @error))
  (#not-has-ancestor? @_c loop_statement))
; }}}
; 10.13 Return statement {{{
((return_statement
   "return" @_c @error @error.scope.return) @error.region
   (#not-has-ancestor? @_c function_body procedure_body))

; Statements after return statement are unreachable (dead code)
((return_statement) . (_)* @error.region.unreachble)
; }}}
; 11.2 Block statement {{{
((block_statement
         . (label [(identifier)  (extended_identifier)]  @_h @error @error.repeated.name)
   at_end:        [(simple_name) (extended_simple_name)] @_t @error @error.repeated.name .)
           (#not-eq? @_h @_t))
; }}}
; 11.3 Process statement {{{
((process_statement
         . (label [(identifier)  (extended_identifier)]  @_h @error @error.repeated.name)
   at_end:        [(simple_name) (extended_simple_name)] @_t @error @error.repeated.name .)
           (#not-eq? @_h @_t))
; }}}
; 11.6 Concurrent signal assignments {{{
(concurrent_signal_assignment
   target: (aggregate
               (named_element_association "=>") @error) @error.region)
; }}}
; 11.7 Component instantiation statements {{{
(component_instantiation_statement
   (map_aspect [
      (generic_clause     (semicolon) @error @error.unexpected.semicolon)
      (generic_map_aspect (semicolon) @error @error.unexpected.semicolon)
      (port_clause        (semicolon) @error @error.unexpected.semicolon)
      (port_map_aspect    (semicolon) @error @error.unexpected.semicolon)

      (generic_map_aspect [(any) (default)] @error)
   ])
)
; }}}
; 11.8 Generate statement {{{
((for_generate_statement
         . (label [(identifier)  (extended_identifier)]  @_h @error @error.repeated.name)
   at_end:        [(simple_name) (extended_simple_name)] @_t @error @error.repeated.name .)
           (#not-eq? @_h @_t))

((if_generate_statement
         . (label [(identifier) (extended_identifier)] @_h @error @error.repeated.name)
   at_end: [(simple_name) (extended_simple_name)] @_t @error @error.repeated.name .)
           (#not-eq? @_h @_t))

((_
 . (label [(identifier) (extended_identifier)] @_h @error @error.repeated.name )
   (generate_statement_body
      at_end: [(simple_name) (extended_simple_name)] @_t @error @error.repeated.name .))
   (#not-eq? @_h @_t))
; }}}
; 12.4 Use clauses {{{
(selected_name
   prefix: (selected_name
             prefix: ((simple_name) @_p
                      (#vim-match? @_p "^[iI][eE]{3}$"))
             suffix: ((simple_name) @_s @error @error.illegal.package.ieee
                      (#not-vim-match? @_s "^\%([nN][uU][mM][eE][rR][iI][cC]_\%([bB][iI][tT]|[sS][tT][dD]\)\%(_\%([uU][nN]\)?[sS][iI][gG][nN][eE][dD]\)?|\%([fF][iI][xX][eE][dD]|[fF][lL][oO][aA][tT]\)\%(_[gG][eE][nN][eE][rR][iI][cC]\)?_[pP][kK][gG]|[fF][iI][xX][eE][dD]_[fF][lL][oO][aA][tT]_[tT][yY][pP][eE][sS]|[sS][tT][dD]_[lL][oO][gG][iI][cC]_\%(1164|[tT][eE][xX][tT][iI][oO]|[aA][rR][iI][tT][hH]|[mM][iI][sS][cC]|\%([uU][nN]\)?[sS][iI][gG][nN][eE][dD]\)|[mM][aA][tT][hH]_\%([rR][eE][aA][lL]|[cC][oO][mM][pP][lL][eE][xX]\)\)$"))
             ) @error.region)

(selected_name
   prefix: (selected_name
             prefix: ((simple_name) @_p
                      (#vim-match? @_p "^[iI][eE]{3}$"))
             suffix: ((simple_name) @_s @warning @warning.package.ieee.synopsys
                      (#vim-match? @_s "^[sS][tT][dD]_[lL][oO][gG][iI][cC]_\%([aA][rR][iI][tT][hH]|[mM][iI][sS][cC]|\%([uU][nN]\)?[sS][iI][gG][nN][eE][dD]]\)$"))
             ) @warning.region @warning.region.package.ieee.synopsys)

(selected_name
   prefix: (selected_name
             prefix: ((simple_name) @_p
                      (#vim-match? @_p "^[sS][tT][dD]$"))
             suffix: ((simple_name) @_s @error
                      (#not-vim-match? @_s "^\%([tT][eE][xX][tT][iI][oO]|[eE][nN][vV]\)$"))
             ) @error.region)
; }}}
; 13.3 Context declarations {{{
((context_declaration
         . [(identifier)  (extended_identifier)] @error.declaration
   at_end: [(simple_name) (extended_simple_name)] @error .)
           (#not-eq? @error.declaration @error))
; }}}
; 15.5.2 Decimal literals {{{
((negative_exponent) @error
 (#has-parent? @error integer_decimal based_integer))
; }}}
; PSL 6.1.2 Sequences {{{
(PSL_Repeated_SERE
   (PSL_Count
      operator: "+"
      (simple_expression) @error) @error.region)

(PSL_Repeated_SERE
   (PSL_Count
      operator: "=" . "]" @error @error.missing.count) @error.region)

(PSL_Repeated_SERE
   (PSL_Count
      operator: "->" . "]" @error @error.missing.count) @error.region)

(PSL_Repeated_SERE
   (PSL_Count
      operator: "->"
      (simple_expression (sign operator: "-" @error @error.expecting.positive_number)) @error.region))

(PSL_Repeated_SERE
   ((PSL_Count "[" @error @error.missing.operator) @error.region
    (#not-has-children @error.region "*" "+" "=" "->")))
; }}}
; PSL 6.2.1 FL Properties {{{
(PSL_Extended_Ocurrence_FL_Property
   (PSL_Count
      operator: _ @error) @error.region)

(PSL_Extended_Ocurrence_FL_Property
   operator: ["next" "next_event"]
   (PSL_Count [
         (ascending_range "to" @error)
         (descending_range "downto" @error)
         (attribute_name (predefined_designator) @error)
   ] @error.expecting.number) @error.region)

(PSL_Extended_Ocurrence_FL_Property
   operator: ["next_a" "next_e" "next_event_a" "next_event_e"]
   (PSL_Count
      (simple_expression) @error @error.expecting.range) @error.region)

(PSL_Extended_Ocurrence_FL_Property
   operator: ["next_a" "next_e"]
   (PSL_Count
      (_
         (simple_expression [
            ((simple_name) @error @error.expecting.finite_range
             (#vim-match? @error "^[iI][nN][fF]$"))
            (sign
               ((simple_name) @error @error.expecting.finite_range
                (#vim-match? @error "^[iI][nN][fF]$")))
            ]) @error.region)))

(PSL_Extended_Ocurrence_FL_Property
   operator: ["next_event"]
   (PSL_Count
      (simple_expression
         (sign operator: "-" @error @error.expecting.positive_number))) @error.region)

(PSL_Extended_Ocurrence_FL_Property
   operator: ["next_event_a" "next_event_e"]
   (PSL_Count
      (_
         (simple_expression
            (sign "-" @error @error.expecting.positive_number)) @error.region)))
; }}}

(ERROR) @error @error.parser

[
   (identifier)
   (extended_identifier)
   (PSL_Identifier)
   (simple_name)
   (extended_simple_name)
] @variable
