(done_task) @comment
(task (priority) @keyword)
(task (date) @comment)
(task (kv) @comment)
(task (project) @string)
(task (context) @type)

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
