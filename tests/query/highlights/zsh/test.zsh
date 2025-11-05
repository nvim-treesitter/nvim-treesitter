#!/bin/zsh
# ^^^^^^^^ @comment @spell

# Basic comment
# <- @comment @spell

# Variables and assignments
name="value"
#^^^ @variable @constant
#   ^ @operator
#    ^^^^^^^ @string

export PATH="/usr/bin:$PATH"
#^^^^^ @keyword.import
#      ^^^^ @variable @constant @variable.builtin
#          ^ @operator
#           ^^^^^^^^^^^^^^^^ @string
#                     ^ @punctuation.special
#                      ^^^^ @variable.builtin

# Function definition
function myfunction() {
#^^^^^^^ @keyword.function
#        ^^^^^^^^^^ @function @number
    echo "Hello World"
    #^^^ @function.call @function.builtin @number
    #    ^^^^^^^^^^^^^ @string
}

myfunction() {
#^^^^^^^^^ @function @number
    local var="test"
    #^^^^ @keyword
    #     ^^^ @variable @constant
    #        ^ @operator
    #         ^^^^^^ @string
}

# Built-in commands
echo "Hello"
#^^^ @function.call @function.builtin @number
#    ^^^^^^^ @string

cd /home/user
#^ @function.call @function.builtin @number
#  ^^^^^^^^^^ @variable.parameter @number

ls -la
#^ @function.call @number
#  ^^^ @variable.parameter @number

# Control structures
if [[ -f "$file" ]]; then
#^ @keyword.conditional
#  ^^ @punctuation.bracket
#     ^^ @operator @operator
#        ^^^^^^^ @string
#         ^ @punctuation.special @none
#                ^^ @punctuation.bracket
#                  ^ @punctuation.delimiter
#                     ^^^^ @keyword.conditional
    echo "File exists"
    #^^^ @function.call @function.builtin @number
    #    ^^^^^^^^^^^^^ @string
fi
#^ @keyword.conditional

for i in {1..10}; do
#^^ @keyword.repeat
#      ^^ @keyword.conditional
#        ^ @punctuation.bracket
#         ^ @number
#          ^^ @operator
#            ^^ @number
#              ^ @punctuation.bracket
#               ^ @punctuation.delimiter
#                  ^^ @keyword.repeat
    echo $i 
    #^^^ @function.call @function.builtin @number
    #    ^ @punctuation.special
done
#^^^ @keyword.repeat

while read line; do
#^^^^ @keyword.repeat
#     ^^^^ @function.call @function.builtin @number
#          ^^^^ @variable.parameter @number
#              ^ @punctuation.delimiter
#                ^^ @keyword.repeat
    echo "$line"
    #^^^ @function.call @function.builtin @number
    #    ^^^^^^^ @string
    #     ^ @punctuation.special @none
done
#^^^ @keyword.repeat

case $input in
#^^^ @keyword.conditional
#    ^ @punctuation.special @none
#           ^^ @keyword.conditional
    "yes"|"y")
    #^^^^ @string @variable.parameter
    #    ^ @operator
    #     ^^^ @string @variable.parameter
    #        ^ @punctuation.bracket
        echo "Yes"
        #^^^ @function.call @function.builtin @number
        #    ^^^^^ @string
        ;; 
        #^ @punctuation.delimiter
    "no"|"n")
    #^^^ @string @variable.parameter
    #   ^ @operator
    #    ^^^ @string @variable.parameter
    #       ^ @punctuation.bracket
        echo "No"
        #^^^ @function.call @function.builtin @number
        #    ^^^^ @string
        ;;
        #^ @punctuation.delimiter
    *)
   #^ @string.regexp
   # ^ @punctuation.bracket
        echo "Unknown"
        #^^^ @function.call @function.builtin @number
        #    ^^^^^^^^^ @string
        ;;
        #^ @punctuation.delimiter
esac
#^^^ @keyword.conditional

# Arrays
arr=(one two three)
#^^ @variable @constant
#  ^ @operator
#   ^ @punctuation.bracket
#                 ^ @punctuation.bracket

echo ${arr[1]}
#^^^ @function.call @function.builtin @number
#    ^ @punctuation.special
#     ^ @punctuation.special
#         ^ @punctuation.bracket
#          ^ @number
#           ^ @punctuation.bracket
#            ^ @punctuation.special

# Parameter expansion
echo ${name:-default}
#^^^ @function.call @function.builtin @number
#    ^^ @punctuation.special
#                   ^ @punctuation.special

echo ${#name}
#^^^ @function.call @function.builtin @number
#    ^^ @punctuation.special
#           ^ @punctuation.special

# Command substitution
result=$(date)
#^^^^^ @variable @constant
#     ^ @operator
#      ^ @punctuation.special
#       ^ @punctuation.special
#        ^^^^ @function.call @number
#            ^ @punctuation.special

result=`date`
#^^^^^ @variable @constant
#     ^ @operator
#       ^^^^ @function.call @number

# Pipes and redirection
ls | grep "test" > output.txt
#^ @function.call @number
#  ^ @operator
#    ^^^^ @function.call @number
#         ^^^^^^ @string
#                ^ @operator
#                  ^^^^^^^^^^ @string.special.path @number

cat < input.txt >> output.txt
#^^ @function.call @number
#   ^ @operator
#     ^^^^^^^^^ @string.special.path @number
#               ^^ @operator
#                  ^^^^^^^^^^ @string.special.path @number

# Process substitution
diff <(ls dir1) <(ls dir2)
#^^^ @function.call @number
#    ^ @punctuation.special
#     ^ @punctuation.special
#      ^^ @function.call @number
#         ^^^^ @variable.parameter @number
#                ^^ @punctuation.special
#                  ^^ @function.call @number
#                     ^^^^ @variable.parameter @number
#                        ^ @punctuation.special @punctuation.bracket

# Test commands
[[ -f file.txt ]]
#^ @punctuation.bracket
#  ^^ @operator @operator
#              ^^ @punctuation.bracket

 [ -n "$var" ]
#^ @punctuation.bracket
#  ^^ @operator @operator
#     ^^^^^ @string
#      ^ @punctuation.special
#            ^ @punctuation.bracket

# Arithmetic expansion
echo $((2 + 3))
#^^^ @function.call @function.builtin @number
#    ^ @punctuation.special
#     ^^ @punctuation.special
#       ^ @number
#         ^ @operator
#           ^ @number
#             ^^ @punctuation.special @punctuation.bracket

# Globbing patterns
ls *.txt
#^ @function.call @number

# Brace expansion
echo {a,b,c}
#^^^ @function.call @function.builtin @number

# Here documents
cat << EOF
#^^ @function.call @number
#   ^^ @operator
#      ^^^ @label
This is a heredoc
#^^^^^^^^^^^^^^^^^ @string
EOF
#^^ @label

cat <<< "string"
#^^ @function.call @number
#   ^^ @operator
#     ^ @operator
#       ^^^^^^^^ @string

# Special variables
echo $0 $1 $@ $* $# $?
#^^^ @function.call @function.builtin @number
#    ^^ @punctuation.special @none @variable.builtin
#     ^ @variable.builtin
#       ^^ @punctuation.special @none @variable.builtin
#        ^ @variable.builtin
#          ^^ @punctuation.special @none @variable.builtin
#           ^ @variable.builtin
#             ^^ @punctuation.special @none @variable.builtin
#              ^ @variable.builtin
#                ^^ @punctuation.special @none @variable.builtin
#                 ^ @variable.builtin
#                   ^^ @punctuation.special @none @variable.builtin
#                    ^ @variable.builtin
# NOTE: $$ is not captured by current query/grammar

# Conditional operators
[[ $a == $b ]] && echo "equal"
#^ @punctuation.bracket
#  ^ @punctuation.special @none
#     ^^ @operator @operator
#        ^ @punctuation.special @none
#           ^^ @punctuation.bracket
#              ^^ @operator
#                 ^^^^ @function.builtin @function.call @number
#                      ^^^^^^^ @string

[[ $a != $b ]] || echo "not equal"
#^ @punctuation.bracket
#  ^^ @punctuation.special @none
#     ^^ @operator
#        ^^ @punctuation.special @none
#              ^^ @operator
#                 ^^^^ @function.call @function.builtin @number
#                      ^^^^^^^^^^^ @string

# Background jobs
sleep 10 &
#^^^^ @function.call @number
#     ^^ @number
#        ^ @punctuation.delimiter

# Negation
 ! command
#^ @operator
  #^^^^^^ @function.call @number

# File descriptors
exec 3> file.txt
#^^^ @function.call @function.builtin @number
#    ^ @operator
#     ^ @operator
#       ^^^^^^^^ @string.special.path @number

# ZSH-specific features
setopt AUTO_CD
#^^^^^ @function.call @number
#      ^^^^^^^ @variable.parameter @number

autoload -U compinit
#^^^^^^^ @function.call @number
#        ^^ @variable.parameter @number
#           ^^^^^^^^ @variable.parameter @number

# Associative arrays
typeset -A hash
#^^^^^^ @keyword
#       ^^ @variable.parameter @number
#          ^^^^ @variable.parameter @constant

hash[key]="value"
#^^^ @variable @constant
#   ^ punctuation.bracket
#       ^ punctuation.bracket
#        ^ @operator
#         ^^^^^^^ @string

# Regular expressions
[[ "text" =~ ^[a-z]+$ ]]
#^ @punctuation.bracket
#  ^^^^^^ @string
#         ^^ @operator
#            ^^^^^^^^^ @string.regexp
#                     ^^ @punctuation.bracket

# Quotes and escaping
echo "double quotes with $var"
#^^^ @function.call @function.builtin @number
#    ^^^^^^^^^^^^^^^^^^^^^^^^^ @string
#                        ^ @punctuation.special @none

echo 'single quotes $var'
#^^^ @function.call @function.builtin @number
#    ^^^^^^^^^^^^^^^^^^^^ @string

echo $'ansi-c quotes\n'
#^^^ @function.call @function.builtin @number
#     ^^^^^^^^^^^^^^^^^ @string

echo "escaped \" quote"
#^^^ @function.call @function.builtin @number
#    ^^^^^^^^^^^^^^^^^^ @string

# Command chaining
cmd1 && cmd2 || cmd3
#^^^ @function.call @number
#    ^^ @operator
#       ^^^^ @function.call @number
#            ^^ @operator
#               ^^^^ @function.call @number
