(keyword_definition) @indent.begin

(test_case_definition) @indent.begin

(for_statement) @indent.begin

(for_statement
  "END" @indent.branch)

(for_statement
  right: (_
    (arguments
      (continuation
        (ellipses) @indent.branch))))

(while_statement) @indent.begin

(while_statement
  "END" @indent.branch)

(if_statement) @indent.begin

(if_statement
  (elseif_statement) @indent.branch)

(if_statement
  (else_statement) @indent.branch)

(if_statement
  "END" @indent.branch)

(try_statement) @indent.begin

(try_statement
  (except_statement) @indent.branch)

(try_statement
  (finally_statement) @indent.branch)

(try_statement
  (else_statement) @indent.branch)

(try_statement
  "END" @indent.branch)
