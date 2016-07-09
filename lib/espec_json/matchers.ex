defmodule ESpec.Json.Matchers do
  alias ESpec.Json.Matchers.BeJsonEql
  alias ESpec.Json.Matchers.IncludeJson

  def be_json_eql(json),  do: {BeJsonEql, json}
  def include_json(json), do: {IncludeJson, json}
end
