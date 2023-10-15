if (( $(tree-sitter parse test/Petalisp/**/*.lisp -q | wc -l) > 2 )); then
#  ^ punctuation.special
#                                                                  ^ punctuation.special
#                                                           ^ punctuation.bracket
   exit 1 
fi
