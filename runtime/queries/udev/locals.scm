;; labels

(assignment
  key: "LABEL"
  (value (content) @definition))

(assignment
  key: "GOTO"
  (value (content) @reference))

;; env vars

(assignment
  key: "ENV"
  (env_var) @definition.var)

(match
  key: "ENV"
  (env_var) @reference)

(var_sub (env_var) @reference)

;; misc

[
  (attribute)
  (kernel_param)
  (seclabel)
] @reference
