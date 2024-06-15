init <- 1
# ^ @variable
#     ^ @operator
#       ^ @number.float

r"{(\1\2)}" -> `%r%`
#  ^ @string
#           ^ @operator
#               ^ @variable


foo <- c(1L, 2L)
#      ^ @function.call
#        ^ @number

b <- list(TRUE, FALSE, NA, Inf)
#          ^ @boolean
#                ^ @boolean
#                      ^ @constant.builtin
#                           ^ @constant.builtin

b <- list(name = "r", version = R.version$major)
#          ^ @variable.parameter
#                 ^ @string
#                                        ^ @operator
#                                           ^ @variable

Lang$new(name = "r")$print()
#     ^ @variable

for(i in 1:10) {
# <- @keyword.repeat
#      ^ @keyword
}

add <- function(a, b = 1, ...) {
#        ^ @keyword.function
#               ^ @variable.parameter
#                  ^ @variable.parameter
#                         ^ @constant.builtin
  return(a + b)
}

base::letters
# ^ @module
#        ^ @variable
