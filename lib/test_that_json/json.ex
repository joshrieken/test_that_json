defmodule TestThatJson.Json do
  import TestThatJson.Exclusion
  import TestThatJson.Parsing

  def has_only_properties?(subject, value) do
    {processed_subject, processed_value} = process(subject, value)
    do_has_only_properties?(processed_subject, processed_value)
  end

  def has_properties?(subject, value) do
    {processed_subject, processed_value} = process(subject, value)
    do_has_properties?(processed_subject, processed_value)
  end

  # PRIVATE ##################################################

  def do_has_only_properties?(subject_map, other_map) when is_map(subject_map) and is_map(other_map) do
    map_keys = Map.keys(subject_map)
    other_map_keys = Map.keys(other_map)

    case Enum.sort(map_keys) == Enum.sort(other_map_keys) do
      true  -> do_has_properties?(subject_map, other_map)
      false -> false
    end
  end
  def do_has_only_properties?(invalid_subject, invalid_value) do
    {:error, ArgumentError, [invalid_subject, invalid_value], "Arguments must be maps"}
  end

  def do_has_properties?(subject_map, other_map) when is_map(subject_map) and is_map(other_map) do
    Enum.all?(Map.keys(other_map), fn(key) -> Map.get(subject_map, key) == Map.get(other_map, key) end)
  end
  def do_has_properties?(invalid_subject, invalid_value) do
    {:error, ArgumentError, [invalid_subject, invalid_value], "Arguments must be maps"}
  end

  defp process(subject, value) do
    normalized_subject = normalize(subject)
    normalized_value   = normalize(value)

    scrubbed_subject = scrub(normalized_subject)
    scrubbed_value   = scrub(normalized_value)

    {scrubbed_subject, scrubbed_value}
  end

  defp normalize(value) do
    case parse(value) do
      {:ok, parsed_value} -> parsed_value
      {:error, _}         -> value
    end
  end

  defp scrub(value), do: exclude_keys(value)
end
