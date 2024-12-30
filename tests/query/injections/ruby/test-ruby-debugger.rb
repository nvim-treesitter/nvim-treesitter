binding.b(do: "puts 'Hello, world!'")
#              ^ @ruby

binding.b(pre: "pp [1, 2, 3]")
#               ^ @ruby

binding.break(do: "puts 'Hello, world!'")
#                  ^ @ruby

binding.break(pre: "pp [1, 2, 3]")
#                   ^ @ruby
