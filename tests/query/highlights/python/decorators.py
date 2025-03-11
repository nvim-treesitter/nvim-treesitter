from dataclasses import dataclass


@dataclass
#^^^^^^^^^ @attribute
class Data:
    _foo: str

    @property
#   ^ @attribute
#    ^^^^^^^^ @attribute.builtin
    def foo(self) -> str:
        return self._foo


@pytest.mark.filterwarnings("ignore::DeprecationWarning")
#^^^^^^ @variable
#       ^^^^ @variable.member
#            ^^^^^^^^^^^^^^ @attribute
def test_func():
    pass

