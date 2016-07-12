defmodule TestThatJson.ESpec.Matchers.HaveJsonProperties do
  use ESpec.Assertions.Interface

  import TestThatJson.Exclusion
  import TestThatJson.Parsing

  defp match(subject, value) do
    parsed_subject   = parse!(subject)
    scrubbed_subject = exclude_keys(parsed_subject)

    parsed_value     = parse!(value)
    scrubbed_value   = exclude_keys(parsed_value)

    result = has_json_properties?(scrubbed_subject, scrubbed_value)

    {result, result}
  end

  defp success_message(subject, value, _result, positive) do
    has = if positive, do: "has", else: "doesn't have"
    "`#{inspect subject}` #{has} JSON properties `#{inspect value}`."
  end

  defp error_message(subject, value, _result, positive) do
    to = if positive, do: "to have", else: "not to have"
    but = if positive, do: "doesn't", else: "does"
    "Expected `#{inspect subject}` #{to} JSON properties `#{inspect value}`, but it #{but}."
  end

  defp has_json_properties?(subject_map, value_map) when is_map(subject_map) and is_map(value_map) do
    Enum.all?(Map.keys(value_map), fn(key) -> Map.get(subject_map, key) == Map.get(value_map, key) end)
  end
  defp has_json_properties?(map_subject, value) when is_map(map_subject) do
    raise ArgumentError, "Value must be a JSON map when using have_json_properties, but it isn't: #{inspect value}"
  end
  defp has_json_properties?(subject, map_value) when is_map(map_value) do
    raise ArgumentError, "Subject must be a JSON map when using have_json_properties, but it isn't: #{inspect subject}"
  end
  defp has_json_properties?(_subject, _value) do
    raise ArgumentError, "Subject and value must be JSON maps when using have_json_properties, but neither is."
  end
end
