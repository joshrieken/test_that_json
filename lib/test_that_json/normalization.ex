defmodule TestThatJson.Normalization do
  def prettify(json) do
    JSX.prettify(json)
  end

  def prettify!(json) do
    JSX.prettify!(json)
  end
end
