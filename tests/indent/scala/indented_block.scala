trait A:
  def b: Int
class B:
  def c = 2
object C extends B:
  c match
    case 1 => println("1")
