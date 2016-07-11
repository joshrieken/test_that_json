defmodule TestThatJson.Parsing do
  def parse!(json) do
    Poison.decode!(json)
  end

  def parse(json) do
    Poison.decode(json)
  end
end
