class Fields:
    type: str
#   ^^^^ @variable.member

    def __init__(self, type: str, fields: list[int]) -> None:
#                ^^^^ @variable.builtin
#                      ^^^^ @variable.parameter
#                                 ^^^^^^ @variable.parameter
#                                              ^^^ @type.builtin
#                                                       ^^^^ @constant.builtin
        self.fields = fields
#            ^^^^^^ @variable.member
        self.type = type  # this cannot be highlighted correctly by Treesitter
#            ^^^^ @variable.member
        self.__dunderfield__ = None
#            ^^^^^^^^^^^^^^^ @variable.member
        self._FunKyFielD = 0
#            ^^^^^^^^^^^ @variable.member
        self.NOT_A_FIELD = "IM NOT A FIELD"
#            ^^^^^^^^^^^ @constant

Fields(type="schema", fields=[0, 1])
#      ^^^^ @variable.parameter
#                     ^^^^^^ @variable.parameter
