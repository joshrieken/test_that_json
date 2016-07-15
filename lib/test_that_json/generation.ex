defmodule TestThatJson.Generation do
  alias TestThatJson.Normalization

  def generate(value) do
    JSX.encode(value)
  end

  def generate!(value) do
    JSX.encode!(value)
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
