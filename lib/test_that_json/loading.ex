defmodule TestThatJson.Loading do
  alias TestThatJson.Generation
  alias TestThatJson.Parsing

  def load(path) do
    with {:ok, json}  <- File.read(path),
         {:ok, value} <- Parsing.parse(json),
         do: Generation.generate(value)
  end

  def load!(path) do
    json = File.read!(path)
    value = Parsing.parse!(json)
    Generation.generate!(value)
  end
end
