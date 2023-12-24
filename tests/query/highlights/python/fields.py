class Fields:
    def __init__(self, fields: list[int]) -> None:
#                                   ^^^ @type.builtin
#                                            ^^^^ @constant.builtin
        self.fields = fields
#            ^^^^^^ @variable.member
        self.__dunderfield__ = None
#            ^^^^^^^^^^^^^^^ @variable.member
        self._FunKyFielD = 0
#            ^^^^^^^^^^^ @variable.member
        self.NOT_A_FIELD = "IM NOT A FIELD"
#            ^^^^^^^^^^^ @constant
