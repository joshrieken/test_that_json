defmodule TestThatJson.Json do
  alias TestThatJson.Exclusion
  alias TestThatJson.Parsing
  alias TestThatJson.Pathing

  @type json_object :: String.t | map
  @type json_array :: String.t | list
  @type json_string :: String.t
  @type json_number :: String.t | number
  @type json_value :: json_object | json_array | json_string | json_number

  @doc """
  Receives a subject and a value and returns whether they are equal.
  """
  @spec equals?(json_value, json_value) :: boolean
  def equals?(subject, value) do
    {processed_subject, processed_value} = process(subject, value)
    do_equals?(processed_subject, processed_value)
  end

  @doc """
  Receives a subject and a value and returns whether the subject has all keys
  specified by the value.
  """
  @spec has_keys?(json_object, json_array | json_string) :: boolean
  def has_keys?(subject, value) do
    {processed_subject, processed_value} = process(subject, value)
    do_has_keys?(processed_subject, processed_value)
  end

  @doc """
  Receives a subject and a value and returns whether the subject contains
  only the keys specified by the value.
  """
  @spec has_only_keys?(json_object, json_array | json_string) :: boolean
  def has_only_keys?(subject, value) do
    {processed_subject, processed_value} = process(subject, value)
    do_has_only_keys?(processed_subject, processed_value)
  end

  @doc """
  Receives a subject and a value and returns whether the subject contains the
  values specified by the value.

  If the value is a list, returns whether all values in the list are in the subject.

  If the value is a JSON array as a `String.t`, it is not treated the same as
  a list. Instead, returns whether that list itself is one of the values in the subject.
  """
  @spec has_values?(json_value, json_value) :: boolean
  def has_values?(subject, value) do
    {processed_subject, processed_value} = process_for_values(subject, value)
    do_has_values?(processed_subject, processed_value)
  end

  @doc """
  Receives a subject and a value and returns whether the subject contains only
  the values specified by the value.
  """
  @spec has_only_values?(json_value, json_value) :: boolean
  def has_only_values?(subject, value) do
    {processed_subject, processed_value} = process_for_values(subject, value)
    do_has_only_values?(processed_subject, processed_value)
  end

  @doc """
  Receives a subject and a value and returns whether the subject contains the
  properties (or key value pairs) specified by the value.
  """
  @spec has_properties?(json_object, json_object) :: boolean
  def has_properties?(subject, value) do
    {processed_subject, processed_value} = process(subject, value)
    do_has_properties?(processed_subject, processed_value)
  end

  @doc """
  Receives a subject and a value and returns whether the subject contains only
  the properties (or key value pairs) specified by the value.
  """
  @spec has_only_properties?(json_object, json_object) :: boolean
  def has_only_properties?(subject, value) do
    {processed_subject, processed_value} = process(subject, value)
    do_has_only_properties?(processed_subject, processed_value)
  end

  @doc """
  Receives a subject and a path and returns whether the path exists within the subject.
  """
  @spec has_path?(json_object | json_array, String.t) :: boolean
  def has_path?(subject, path) do
    processed_subject = process(subject)
    do_has_path?(processed_subject, path)
  end






  # PRIVATE ##################################################

  defp do_equals?(subject, value) do
    subject == value
  end

  defp do_has_keys?(subject_map, list_value) when is_map(subject_map) and is_list(list_value) do
    keys = Map.keys(subject_map)
    Enum.all?(list_value, &Enum.member?(keys, &1))
  end
  defp do_has_keys?(subject_map, string_value) when is_map(subject_map) and is_binary(string_value) do
    keys = Map.keys(subject_map)
    Enum.member?(keys, string_value)
  end
  defp do_has_keys?(subject_map, invalid_value) when is_map(subject_map) do
    {:error, {ArgumentError, [invalid_value], "Value must be a list or a String.t"}}
  end
  defp do_has_keys?(invalid_subject, value) when is_list(value) or is_binary(value) do
    {:error, {ArgumentError, [invalid_subject], "Subject must be a map"}}
  end
  defp do_has_keys?(invalid_subject, invalid_value) do
    {:error, {ArgumentError, [invalid_subject, invalid_value], "Subject must be a map and value must be a list or a String.t"}}
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
    {:error, {ArgumentError, [invalid_value], "Value must be a list or a String.t"}}
  end
  defp do_has_only_keys?(invalid_subject, value) when is_list(value) or is_binary(value) do
    {:error, {ArgumentError, [invalid_subject], "Subject must be a map"}}
  end
  defp do_has_only_keys?(invalid_subject, invalid_value) do
    {:error, {ArgumentError, [invalid_subject, invalid_value], "Subject must be a map and value must be a list or a String.t"}}
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
    {:error, {ArgumentError, [invalid_subject, invalid_value], "Arguments must be maps"}}
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
    {:error, {ArgumentError, [invalid_subject, invalid_value], "Arguments must be maps"}}
  end

  defp do_has_path?(subject, path) when is_binary(path) do
    Pathing.value_at_path(subject, path)
    true
  rescue
    TestThatJson.PathNotFoundError -> false
  end





  defp process(subject) do
    parsed_subject = parse(subject)
    scrub(parsed_subject)
  end
  defp process(subject, value) do
    processed_subject = process(subject)
    processed_value   = process(value)
    {processed_subject, processed_value}
  end

  defp process_for_values(subject, value) do
    parsed_subject = parse(subject)
    parsed_value   = parse_for_values(value)

    scrubbed_subject = scrub(parsed_subject)
    scrubbed_value   = scrub(parsed_value)

    {scrubbed_subject, scrubbed_value}
  end

  defp parse(value) do
    case Parsing.parse(value) do
      {:ok, parsed_value} -> parsed_value
      {:error, _}         -> value
    end
  end

  defp parse_for_values(value) when is_binary(value) do
    case Parsing.parse(value) do
      {:ok, parsed_value} ->
        case parsed_value do
          parsed_value when is_list(parsed_value) -> [parsed_value]
          parsed_value                            -> parsed_value
        end
      {:error, _} -> value
    end
  end
  defp parse_for_values(value), do: parse(value)

  defp scrub(value), do: Exclusion.exclude_keys(value)
end
