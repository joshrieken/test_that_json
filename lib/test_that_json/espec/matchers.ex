defmodule TestThatJson.ESpec.Matchers do
  alias TestThatJson.ESpec.Matchers.BeJsonEql

  alias TestThatJson.ESpec.Matchers.HaveJsonKeys
  alias TestThatJson.ESpec.Matchers.HaveOnlyJsonKeys

  alias TestThatJson.ESpec.Matchers.HaveJsonValues
  alias TestThatJson.ESpec.Matchers.HaveOnlyJsonValues

  alias TestThatJson.ESpec.Matchers.HaveJsonProperties

  def be_json_eql(json), do: {BeJsonEql, json}

  def have_json_keys(value),      do: {HaveJsonKeys,     value}
  def have_only_json_keys(value), do: {HaveOnlyJsonKeys, value}

  def have_json_values(value),      do: {HaveJsonValues,     value}
  def have_only_json_values(value), do: {HaveOnlyJsonValues, value}

  def have_json_properties(value), do: {HaveJsonProperties, value}
end
