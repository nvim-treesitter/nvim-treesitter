#!/bin/zsh
# ^^^^^^^^ @comment

# Basic comment
# <- @comment

# Variables and assignments
name="value"
#^^^ @variable
#   ^ @operator
#    ^^^^^^^ @string

export PATH="/usr/bin:$PATH"
#^^^^^ @keyword.import
#      ^^^^ @variable
#          ^ @operator
#           ^^^^^^^^^^^^^^^^ @string
#                     ^ @punctuation.special
#                      ^^^^ @variable.builtin

# Function definition
function myfunction() {
#^^^^^^^ @keyword.function
#        ^^^^^^^^^^ @function
    echo "Hello World"
    #^^^ @function.call
    #    ^^^^^^^^^^^^^ @string
}

myfunction() {
#^^^^^^^^^ @function
    local var="test"
    #^^^^ @keyword
    #     ^^^ @variable
    #        ^ @operator
    #         ^^^^^^ @string
}

# Built-in commands
echo "Hello"
#^^^ @function.call
#    ^^^^^^^ @string

cd /home/user
#^ @function.call
#  ^^^^^^^^^^ @variable.parameter

ls -la
#^ @function.call
#  ^^^ @variable.parameter

# Control structures
if [[ -f "$file" ]]; then
#^ @keyword.conditional
#  ^^ @punctuation.bracket
#     ^^ @operator
#        ^^^^^^^ @string
#         ^ @punctuation.special
#                ^^ @punctuation.bracket
#                  ^ @punctuation.delimiter
#                    ^^^^ @keyword.conditional
    echo "File exists"
    #^^^ @function.call
    #    ^^^^^^^^^^^^^ @string
fi
#^ @keyword.conditional

for i in {1..10}; do
#^^ @keyword.repeat
#     ^^ @keyword.conditional
#        ^ @punctuation.bracket
#         ^ @number
#          ^^ @operator
#            ^^ @number
#              ^ @punctuation.bracket
#               ^ @punctuation.delimiter
#                 ^^ @keyword.repeat
    echo $i 
    #^^^ @function.call
    #    ^ @punctuation.special
done
#^^^ @keyword.repeat

while read line; do
#^^^^ @keyword.repeat
#     ^^^^ @function.call
#          ^^^^ @variable.parameter
#              ^ @punctuation.delimiter
#                ^^ @keyword.repeat
    echo "$line"
    #^^^ @function.call
    #    ^^^^^^^ @string
    #     ^ @punctuation.special
done
#^^^ @keyword.repeat

case $input in
#^^^ @keyword.conditional
#    ^ @punctuation.special
#           ^^ @keyword.conditional
    "yes"|"y")
    #^^^^ @string
    #    ^ @operator
    #     ^^^ @string
    #        ^ @punctuation.bracket
        echo "Yes"
        #^^^ @function.call
        #    ^^^^^ @string
        ;; 
        #^ @punctuation.delimiter
    "no"|"n")
    #^^^ @string
    #   ^ @operator
    #    ^^^ @string
    #       ^ @punctuation.bracket
        echo "No"
        #^^^ @function.call
        #    ^^^^ @string
        ;;
        #^ @punctuation.delimiter
    *)
   #^ @string.regexp
   # ^ @punctuation.bracket
        echo "Unknown"
        #^^^ @function.call
        #    ^^^^^^^^^ @string
        ;;
        #^ @punctuation.delimiter
esac
#^^^ @keyword.conditional

# Arrays
arr=(one two three)
#^^ @variable
#  ^ @operator
#   ^ @punctuation.bracket
#                 ^ @punctuation.bracket

echo ${arr[1]}
#^^^ @function.call
#    ^ @punctuation.special
#     ^ @punctuation.special
#         ^ @punctuation.bracket
#          ^ @number
#           ^ @punctuation.bracket
#            ^ @punctuation.special

# Parameter expansion
echo ${name:-default}
#^^^ @function.call
#    ^^ @punctuation.special
#                   ^ @punctuation.special

echo ${#name}
#^^^ @function.call
#    ^^ @punctuation.special
#           ^ @punctuation.special

# Command substitution
result=$(date)
#^^^^^ @variable
#     ^ @operator
#      ^ @punctuation.special
#       ^ @punctuation.special
#        ^^^^ @function.call
#            ^ @punctuation.special

result=`date`
#^^^^^ @variable
#     ^ @operator
#       ^^^^ @function.call

# Pipes and redirection
ls | grep "test" > output.txt
#^ @function.call
#  ^ @operator
#    ^^^^ @function.call
#         ^^^^^^ @string
#                ^ @operator
#                  ^^^^^^^^^^ @string.special.path

cat < input.txt >> output.txt
#^^ @function.call
#   ^ @operator
#     ^^^^^^^^^ @string.special.path
#               ^^ @operator
#                  ^^^^^^^^^^ @string.special.path

# Process substitution
diff <(ls dir1) <(ls dir2)
#^^^ @function.call
#    ^ @punctuation.special
#     ^ @punctuation.special
#      ^^ @function.call
#         ^^^^ @variable.parameter
#               ^^ @punctuation.special
#                 ^^ @function.call
#                    ^^^^ @variable.parameter
#                        ^ @punctuation.special

# Test commands
[[ -f file.txt ]]
#^ @punctuation.bracket
#  ^^ @operator
#              ^^ @punctuation.bracket

 [ -n "$var" ]
#^ @punctuation.bracket
#  ^^ @operator
#     ^^^^^ @string
#      ^ @punctuation.special
#            ^ @punctuation.bracket

# Arithmetic expansion
echo $((2 + 3))
#^^^ @function.call
#    ^ @punctuation.special
#     ^^ @punctuation.special
#       ^ @number
#         ^ @operator
#           ^ @number
#            ^^ @punctuation.special

# Globbing patterns
ls *.txt
#^ @function.call

# Brace expansion
echo {a,b,c}
#^^^ @function.call

# Here documents
cat << EOF
#^^ @function.call
#   ^^ @operator
#      ^^^ @label
This is a heredoc
#^^^^^^^^^^^^^^^^^ @string
EOF
#^^ @label

cat <<< "string"
#^^ @function.call
#   ^^ @operator
#     ^ @operator
#       ^^^^^^^^ @string

# Special variables
echo $0 $1 $@ $* $# $?
#^^^ @function.call
#    ^ @punctuation.special
#     ^ @variable.builtin
#       ^ @punctuation.special
#        ^ @variable.builtin
#          ^ @punctuation.special
#           ^ @variable.builtin
#             ^ @punctuation.special
#              ^ @variable.builtin
#                ^ @punctuation.special
#                 ^ @variable.builtin
#                   ^ @punctuation.special
#                    ^ @variable.builtin
# NOTE: $$ is not captured by current query/grammar

# Conditional operators
[[ $a == $b ]] && echo "equal"
#^ @punctuation.bracket
#  ^ @punctuation.special
#     ^^ @operator
#        ^ @punctuation.special
#           ^^ @punctuation.bracket
#              ^^ @operator
#                 ^^^^ @function.builtin
#                      ^^^^^^^ @string

[[ $a != $b ]] || echo "not equal"
#^ @punctuation.bracket
#  ^ @punctuation.special
#     ^^ @operator
#        ^ @punctuation.special
#              ^^ @operator
#                 ^^^^ @function.call
#                      ^^^^^^^^^^^ @string

# Background jobs
sleep 10 &
#^^^^ @function.call
#     ^^ @number
#        ^ @punctuation.delimiter

# Negation
 ! command
#^ @operator
  #^^^^^^ @function.call

# File descriptors
exec 3> file.txt
#^^^ @function.call
#    ^ @operator
#     ^ @operator
#       ^^^^^^^^ @string.special.path

# ZSH-specific features
setopt AUTO_CD
#^^^^^ @function.call
#      ^^^^^^^ @variable.parameter

autoload -U compinit
#^^^^^^^ @function.call
#        ^^ @variable.parameter
#           ^^^^^^^^ @variable.parameter

# Associative arrays
typeset -A hash
#^^^^^^ @keyword
#       ^^ @variable.parameter
#          ^^^^ @variable.parameter

hash[key]="value"
#^^^ @variable
#   ^ punctuation.bracket
#       ^ punctuation.bracket
#        ^ @operator
#         ^^^^^^^ @string

# Regular expressions
[[ "text" =~ ^[a-z]+$ ]]
#^ @punctuation.bracket
#  ^^^^^^ @string
#         ^^ @operator
#            ^^^^^^^^ @string.regexp
#                     ^^ @punctuation.bracket

# Quotes and escaping
echo "double quotes with $var"
#^^^ @function.call
#    ^^^^^^^^^^^^^^^^^^^^^^^^^ @string
#                        ^ @punctuation.special

echo 'single quotes $var'
#^^^ @function.call
#    ^^^^^^^^^^^^^^^^^^^^ @string

echo $'ansi-c quotes\n'
#^^^ @function.call
#     ^^^^^^^^^^^^^^^^^ @string

echo "escaped \" quote"
#^^^ @function.call
#    ^^^^^^^^^^^^^^^^^^ @string

# Command chaining
cmd1 && cmd2 || cmd3
#^^^ @function.call
#    ^^ @operator
#       ^^^^ @function.call
#            ^^ @operator
#               ^^^^ @function.call
