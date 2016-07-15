defmodule TestThatJson.Helpers do
  import TestThatJson.Parsing

  def parse_json(json) do
    parse(json)
  end

  def parse_json!(json) do
    parse!(json)
  end
  end
end
