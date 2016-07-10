defmodule ESpec.Json.Matchers.HaveJsonValues do
  use ESpec.Assertions.Interface

  import ESpec.Json.Exclusion
  import ESpec.Json.Parsing

  defp match(subject, value) do
    parsed_subject   = parse!(subject)
    scrubbed_subject = exclude_keys(parsed_subject)

    parsed_value   = parse_value(value)
    scrubbed_value = exclude_keys(parsed_value)

    result = have_json_values?(scrubbed_subject, scrubbed_value)

    {result, result}
  end

  defp success_message(subject, value, _result, positive) do
    has = if positive, do: "has", else: "doesn't have"
    "`#{inspect subject}` #{has} JSON values `#{inspect value}`."
  end

  defp error_message(subject, value, _result, positive) do
    to = if positive, do: "to have", else: "not to have"
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

  defp have_json_values?(map_subject, list_value) when is_map(map_subject) and is_list(list_value) do
    values = Map.values(map_subject)
    Enum.all?(list_value, &Enum.member?(values, &1))
  end
  defp have_json_values?(map_subject, value) when is_map(map_subject) do
    values = Map.values(map_subject)
    Enum.member?(values, value)
  end
  defp have_json_values?(list_subject, list_value) when is_list(list_subject) and is_list(list_value) and list_subject == list_value, do: true
  defp have_json_values?(list_subject, list_value) when is_list(list_subject) and is_list(list_value) do
    Enum.all?(list_value, &Enum.member?(list_subject, &1))
  end
  defp have_json_values?(list_subject, value) when is_list(list_subject) do
    Enum.member?(list_subject, value)
  end
  defp have_json_values?(subject, value) do
    subject == value
  end
end
