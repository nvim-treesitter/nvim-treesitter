((diff) @injection.content
 (#set! injection.language "diff"))

((rebase_command) @injection.content 
 (#set! injection.language "git_rebase"))
