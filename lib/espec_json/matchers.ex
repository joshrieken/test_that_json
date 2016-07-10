defmodule ESpec.Json.Matchers do
  alias ESpec.Json.Matchers.BeJsonEql

  alias ESpec.Json.Matchers.HaveJsonKeys
  alias ESpec.Json.Matchers.HaveOnlyJsonKeys

  alias ESpec.Json.Matchers.HaveJsonValues

  def be_json_eql(json),             do: {BeJsonEql, json}

  def have_json_keys(list_or_value),      do: {HaveJsonKeys,     list_or_value}
  def have_only_json_keys(list_or_value), do: {HaveOnlyJsonKeys, list_or_value}

  def have_json_values(list_or_value),    do: {HaveJsonValues,   list_or_value}
end
