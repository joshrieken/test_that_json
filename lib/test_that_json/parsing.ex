defmodule TestThatJson.Parsing do
  def parse!(json) when is_binary(json) do
    Poison.decode!(json)
  end
  def parse!(value), do: value

  def parse(json) when is_binary(json) do
    Poison.decode(json)
  end
  def parse(value), do: value
end
