defmodule TestThatJson.ESpec.Matchers.HaveOnlyJsonKeys do
  use ESpec.Assertions.Interface

  import TestThatJson.Exclusion
  import TestThatJson.Parsing

  defp match(subject, value) do
    parsed_subject   = parse!(subject)
    scrubbed_subject = exclude_keys(parsed_subject)

    result = has_only_json_keys?(scrubbed_subject, value)

    {result, result}
  end

  defp success_message(subject, value, _result, positive) do
    has = if positive, do: "has only", else: "doesn't have only"
    "`#{inspect subject}` #{has} JSON keys `#{inspect value}`."
  end

  defp error_message(subject, value, _result, positive) do
    to = if positive, do: "to have only", else: "not to have only"
    but = if positive, do: "doesn't", else: "does"
    "Expected `#{inspect subject}` #{to} JSON keys `#{inspect value}`, but it #{but}."
  end

  defp has_only_json_keys?(subject, list_value) when is_map(subject) and is_list(list_value) do
    keys = Map.keys(subject)
    sorted_keys = Enum.sort(keys)
    sorted_list_value = Enum.sort(list_value)
    sorted_keys == sorted_list_value
  end
  defp has_only_json_keys?(subject, value) when is_map(subject) do
    keys = Map.keys(subject)
    length(keys) == 1 && List.first(keys) == value
  end
  defp has_only_json_keys?(subject, _value) do
    raise ArgumentError, "Subject must be a JSON map when using have_only_json_keys, but it isn't: #{inspect subject}"
  end
end
