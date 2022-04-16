def foo do
  :ok
  |> then(fn v -> v end)
end

def bar do
  :ok
  |> then(fn v ->
    v
  end)
end
