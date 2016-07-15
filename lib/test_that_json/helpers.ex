defmodule TestThatJson.Helpers do
  alias TestThatJson.Generation
  alias TestThatJson.Loading
  alias TestThatJson.Normalization
  alias TestThatJson.Parsing

  def parse_json(json) do
    Parsing.parse(json)
  end

  def parse_json!(json) do
    Parsing.parse!(json)
  end

  def to_json(value) do
    Generation.generate(value)
  end

  def to_json!(value) do
    Generation.generate!(value)
  end

  def prettify_json(json) do
    Normalization.prettify(json)
  end

  def prettify_json!(json) do
    Normalization.prettify!(json)
  end

  def to_prettified_json(value) do
    Generation.generate_prettified(value)
  end

  def to_prettified_json!(value) do
    Generation.generate_prettified!(value)
  end

  def load_json(path) do
    Loading.load(path)
  end

  def load_json!(path) do
    Loading.load!(path)
  end
end
