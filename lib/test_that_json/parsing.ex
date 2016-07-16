defmodule TestThatJson.Parsing do
  def parse!(json) when is_binary(json) do
    JSX.decode!(json)
  rescue
    _ in ArgumentError -> raise TestThatJson.InvalidJsonError
  end
  def parse!(value), do: value

  def parse(json) when is_binary(json) do
    case JSX.decode(json) do
      {:error, _} -> {:error, {TestThatJson.InvalidJsonError, [json], "Invalid JSON"}}
      result      -> result
    end
  end
  def parse(value), do: {:ok, value}
end
