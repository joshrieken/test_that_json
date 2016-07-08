defmodule ESpec.Json.Matchers do
  alias ESpec.Json.Matchers.BeJsonEql

  def be_json_eql(json), do: {BeJsonEql, json}
end
