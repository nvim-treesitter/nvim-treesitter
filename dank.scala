class Foo() {
  def foo() = println("foo")
}

@poo
object Bar {
  def bar() = println("bar")
}

object Main {
  def main = {
    Foo().foo()
    Bar.bar()
  }
}
