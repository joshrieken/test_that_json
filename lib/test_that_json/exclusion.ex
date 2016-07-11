defmodule TestThatJson.Exclusion do
  alias TestThatJson.Configuration

  def exclude_keys(list) when is_list(list) do
    for value <- list, do: exclude_keys(value)
  end
  def exclude_keys(map) when is_map(map) do
    Map.drop(map, excluded_keys)
  end
  def exclude_keys(other), do: other

  def excluded_keys do
    MapSet.new(Configuration.excluded_keys)
  end
end
