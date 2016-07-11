defmodule TestThatJson.ESpec.Matchers do
  alias TestThatJson.ESpec.Matchers.BeJsonEql

  alias TestThatJson.ESpec.Matchers.HaveJsonKeys
  alias TestThatJson.ESpec.Matchers.HaveOnlyJsonKeys

  alias TestThatJson.ESpec.Matchers.HaveJsonValues
  alias TestThatJson.ESpec.Matchers.HaveOnlyJsonValues

  def be_json_eql(json), do: {BeJsonEql, json}

  def have_json_keys(list_or_value),      do: {HaveJsonKeys,     list_or_value}
  def have_only_json_keys(list_or_value), do: {HaveOnlyJsonKeys, list_or_value}

  def have_json_values(list_or_value),      do: {HaveJsonValues,     list_or_value}
  def have_only_json_values(list_or_value), do: {HaveOnlyJsonValues, list_or_value}
end
