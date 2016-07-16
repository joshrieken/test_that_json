defmodule TestThatJson.Generation do
  alias TestThatJson.Normalization

  def generate(value) do
    case JSX.encode(value) do
      {:error, _} -> {:error, {TestThatJson.JsonEncodingError, [value]}}
      value       -> value
    end
  end

  def generate!(value) do
    JSX.encode!(value)
  rescue
    ArgumentError -> raise TestThatJson.JsonEncodingError
  end

  def generate_prettified(value) do
    case generate(value) do
      {:ok, json} -> Normalization.prettify(json)
      error       -> error
    end
  end

  def generate_prettified!(value) do
    json = generate!(value)
    Normalization.prettify!(json)
  end
end
