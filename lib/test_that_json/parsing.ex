defmodule TestThatJson.Parsing do
  def parse!(json) when is_binary(json) do
    JSX.decode!(json)
  rescue
    _ in ArgumentError -> raise TestThatJson.InvalidJsonError
  end
  def parse!(value), do: value

  def parse(json) when is_binary(json) do
    JSX.decode(json)
  end
  def parse(value), do: {:ok, value}
end
