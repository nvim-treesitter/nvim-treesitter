(function_item
  body: (block) @function.inside) @function.around

(filtermap_item
  body: (block) @function.inside) @function.around

(test_item
  body: (block) @test.inside) @test.around

(record_item
  fields: (record_type) @class.inside) @class.around

(variant_item
  constructors: (variant_constructors) @class.inside) @class.around

(line_comment) @comment.inside

(line_comment)+ @comment.around
