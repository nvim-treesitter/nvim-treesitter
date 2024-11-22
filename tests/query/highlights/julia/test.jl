function load_data(::Symbol; ::Int) :: Tuple
# <- @keyword.function
#        ^ @function.call
#                 ^ @punctuation.bracket
#                  ^^ @operator
#                    ^ @type.builtin
#                          ^ @punctuation.delimiter
#                            ^^ @operator
#                              ^^^ @type.builtin
#                                 ^ @punctuation.bracket
#                                   ^^ @operator
#                                      ^ @type.builtin
    dataset = CIFAR10(; Tx = Float32, split = split)
#   ^^^^^^^ @variable
#           ^ @operator
#             ^ @function.call
#                          ^ @operator
#                            ^ @type.builtin
    X = reshape(dataset.features[:, :, :, begin:n_obs], :, n_obs) # flattening the image pixels
#                                         ^^^^^ @variable.builtin
    y = categorical2onehot(dataset.targets[begin:n_obs], N_LABELS)
#                                          ^^^^^ @variable.builtin
    return X, y
#   ^^^^^^ @keyword.return
end
# <- @keyword.function
