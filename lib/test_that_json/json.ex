defmodule TestThatJson.Json do
  alias TestThatJson.Exclusion
  alias TestThatJson.Parsing
  alias TestThatJson.Pathing

  def has_keys?(subject, value) do
    {processed_subject, processed_value} = process(subject, value)
    do_has_keys?(processed_subject, processed_value)
  end

  def has_only_keys?(subject, value) do
    {processed_subject, processed_value} = process(subject, value)
    do_has_only_keys?(processed_subject, processed_value)
  end

  def has_values?(subject, value) do
    {processed_subject, processed_value} = process_for_values(subject, value)
    do_has_values?(processed_subject, processed_value)
  end

  def has_only_values?(subject, value) do
    {processed_subject, processed_value} = process_for_values(subject, value)
    do_has_only_values?(processed_subject, processed_value)
  end

  def has_properties?(subject, value) do
    {processed_subject, processed_value} = process(subject, value)
    do_has_properties?(processed_subject, processed_value)
  end

  def has_only_properties?(subject, value) do
    {processed_subject, processed_value} = process(subject, value)
    do_has_only_properties?(processed_subject, processed_value)
  end

  def has_path?(subject, path) do
    processed_subject = process(subject)
    do_has_path?(processed_subject, path)
  end






  # PRIVATE ##################################################

  defp do_has_keys?(subject_map, list_value) when is_map(subject_map) and is_list(list_value) do
    keys = Map.keys(subject_map)
    Enum.all?(list_value, &Enum.member?(keys, &1))
  end
  defp do_has_keys?(subject_map, string_value) when is_map(subject_map) and is_binary(string_value) do
    keys = Map.keys(subject_map)
    Enum.member?(keys, string_value)
  end
  defp do_has_keys?(subject_map, invalid_value) when is_map(subject_map) do
    {:error, ArgumentError, [invalid_value], "Value must be a list or a String.t"}
  end
  defp do_has_keys?(invalid_subject, value) when is_list(value) or is_binary(value) do
    {:error, ArgumentError, [invalid_subject], "Subject must be a map"}
  end
  defp do_has_keys?(invalid_subject, invalid_value) do
    {:error, ArgumentError, [invalid_subject, invalid_value], "Subject must be a map and value must be a list or a String.t"}
  end

  defp do_has_only_keys?(subject_map, list_value) when is_map(subject_map) and is_list(list_value) do
    keys = Map.keys(subject_map)
    sorted_keys = Enum.sort(keys)
    sorted_list_value = Enum.sort(list_value)
    sorted_keys == sorted_list_value
  end
  defp do_has_only_keys?(subject_map, value) when is_map(subject_map) do
    keys = Map.keys(subject_map)
    length(keys) == 1 && List.first(keys) == value
  end
  defp do_has_only_keys?(subject_map, invalid_value) when is_map(subject_map) do
    {:error, ArgumentError, [invalid_value], "Value must be a list or a String.t"}
  end
  defp do_has_only_keys?(invalid_subject, value) when is_list(value) or is_binary(value) do
    {:error, ArgumentError, [invalid_subject], "Subject must be a map"}
  end
  defp do_has_only_keys?(invalid_subject, invalid_value) do
    {:error, ArgumentError, [invalid_subject, invalid_value], "Subject must be a map and value must be a list or a String.t"}
  end

  defp do_has_values?(map_subject, list_value) when is_map(map_subject) and is_list(list_value) do
    values = Map.values(map_subject)
    Enum.all?(list_value, &Enum.member?(values, &1))
  end
  defp do_has_values?(map_subject, value) when is_map(map_subject) do
    values = Map.values(map_subject)
    Enum.member?(values, value)
  end
  defp do_has_values?(list_subject, list_value) when is_list(list_subject) and is_list(list_value) and list_subject == list_value, do: true
  defp do_has_values?(list_subject, list_value) when is_list(list_subject) and is_list(list_value) do
    Enum.all?(list_value, &Enum.member?(list_subject, &1))
  end
  defp do_has_values?(list_subject, value) when is_list(list_subject) do
    Enum.member?(list_subject, value)
  end
  defp do_has_values?(subject, value) do
    subject == value
  end

  defp do_has_only_values?(map_subject, list_value) when is_map(map_subject) and is_list(list_value) do
    values = Map.values(map_subject)
    sorted_values = Enum.sort(values)
    sorted_list_value = Enum.sort(list_value)
    sorted_values == sorted_list_value
  end
  defp do_has_only_values?(map_subject, value) when is_map(map_subject) do
    subject_values = Map.values(map_subject)
    length(subject_values) == 1 && List.first(subject_values) == value
  end
  defp do_has_only_values?(list_subject, list_value) when is_list(list_subject) and is_list(list_value) do
    list_subject == list_value
  end
  defp do_has_only_values?(list_subject, value) when is_list(list_subject) do
    length(list_subject) == 1 && List.first(list_subject) == value
  end
  defp do_has_only_values?(subject, value) do
    subject == value
  end

  defp do_has_properties?(subject_map, other_map) when is_map(subject_map) and is_map(other_map) do
    Enum.all?(Map.keys(other_map), fn(key) -> Map.get(subject_map, key) == Map.get(other_map, key) end)
  end
  defp do_has_properties?(invalid_subject, invalid_value) do
    {:error, ArgumentError, [invalid_subject, invalid_value], "Arguments must be maps"}
  end

  defp do_has_only_properties?(subject_map, other_map) when is_map(subject_map) and is_map(other_map) do
    map_keys = Map.keys(subject_map)
    other_map_keys = Map.keys(other_map)

    case Enum.sort(map_keys) == Enum.sort(other_map_keys) do
      true  -> do_has_properties?(subject_map, other_map)
      false -> false
    end
  end
  defp do_has_only_properties?(invalid_subject, invalid_value) do
    {:error, ArgumentError, [invalid_subject, invalid_value], "Arguments must be maps"}
  end

  defp do_has_path?(subject, path) when is_binary(path) do
    Pathing.value_at_path(subject, path)
    true
  rescue
    _ in TestThatJson.PathNotFoundError -> false
  end







  defp process(subject) do
    normalized_subject = normalize(subject)
    scrub(normalized_subject)
  end
  defp process(subject, value) do
    processed_subject = process(subject)
    processed_value   = process(value)
    {processed_subject, processed_value}
  end

  defp process_for_values(subject, value) do
    normalized_subject = normalize(subject)
    normalized_value   = normalize_for_values(value)

    scrubbed_subject = scrub(normalized_subject)
    scrubbed_value   = scrub(normalized_value)

    {scrubbed_subject, scrubbed_value}
  end

  defp normalize(value) do
    case Parsing.parse(value) do
      {:ok, parsed_value} -> parsed_value
      {:error, _}         -> value
    end
  end

  defp normalize_for_values(value) when is_binary(value) do
    case Parsing.parse(value) do
      {:ok, parsed_value} ->
        case parsed_value do
          parsed_value when is_list(parsed_value) -> [parsed_value]
          parsed_value                            -> parsed_value
        end
      {:error, _} -> value
    end
  end
  defp normalize_for_values(value), do: normalize(value)

  defp scrub(value), do: Exclusion.exclude_keys(value)
end
