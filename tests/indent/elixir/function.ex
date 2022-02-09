defmodule Foo do
  def bar do
  end

  def baz do
    Map.put(
      %{arguments: :test},
      "key",
    )
  end
end

