defmodule TestThatJson.ESpec.Matchers.HaveOnlyJsonValues do
  use ESpec.Assertions.Interface

  import TestThatJson.Exclusion
  import TestThatJson.Parsing

  defp match(subject, value) do
    parsed_subject   = parse!(subject)
    scrubbed_subject = exclude_keys(parsed_subject)

    parsed_value   = parse_value(value)
    scrubbed_value = exclude_keys(parsed_value)

    result = has_only_json_values?(scrubbed_subject, scrubbed_value)

    {result, result}
  end

  defp success_message(subject, value, _result, positive) do
    has = if positive, do: "has only", else: "doesn't have only"
    "`#{inspect subject}` #{has} JSON values `#{inspect value}`."
  end

  defp error_message(subject, value, _result, positive) do
    to = if positive, do: "to have only", else: "not to have only"
    but = if positive, do: "doesn't", else: "does"
    "Expected `#{inspect subject}` #{to} JSON values `#{inspect value}`, but it #{but}."
  end

  defp parse_value(value) when is_binary(value) do
    case parse(value) do
      {:ok, json} ->
        case json do
          json when is_list(json) -> [json]
          json                    -> json
        end
      {:error, _} -> value
    end
  end
  defp parse_value(value), do: value

  defp has_only_json_values?(subject, list_value) when is_map(subject) and is_list(list_value) do
    values = Map.values(subject)
    sorted_values = Enum.sort(values)
    sorted_list_value = Enum.sort(list_value)
    sorted_values == sorted_list_value
  end
  defp has_only_json_values?(map_subject, value) when is_map(map_subject) do
    subject_values = Map.values(map_subject)
    length(subject_values) == 1 && List.first(subject_values) == value
  end
  defp has_only_json_values?(list_subject, list_value) when is_list(list_subject) and is_list(list_value) do
    list_subject == list_value
  end
  defp has_only_json_values?(list_subject, value) when is_list(list_subject) do
    length(list_subject) == 1 && List.first(list_subject) == value
  end
  defp has_only_json_values?(subject, value) do
    subject == value
  end
end
