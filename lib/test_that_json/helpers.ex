defmodule TestThatJson.Helpers do
  import TestThatJson.Parsing

  def parse_json(value) do
    parse(value)
  end

  def parse_json!(value) do
    parse!(value)
  end
end
