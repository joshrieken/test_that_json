defmodule ESpec.Json.Matchers.HaveJsonKeys do
  use ESpec.Assertions.Interface

  import ESpec.Json.Exclusion
  import ESpec.Json.Parsing

  defp match(subject, value) do
    parsed_subject   = parse!(subject)
    scrubbed_subject = exclude_keys(parsed_subject)

    result = has_json_keys?(scrubbed_subject, value)

    {result, result}
  end

  defp success_message(subject, value, _result, positive) do
    has = if positive, do: "has", else: "doesn't have"
    "`#{inspect subject}` #{has} JSON keys `#{inspect value}`."
  end

  defp error_message(subject, value, _result, positive) do
    to = if positive, do: "to have", else: "not to have"
    but = if positive, do: "doesn't", else: "does"
    "Expected `#{inspect subject}` #{to} JSON keys `#{inspect value}`, but it #{but}."
  end

  defp has_json_keys?(subject, list_value) when is_map(subject) and is_list(list_value) do
    keys = Map.keys(subject)
    Enum.all?(list_value, &Enum.member?(keys, &1))
  end
  defp has_json_keys?(subject, value) when is_map(subject) do
    keys = Map.keys(subject)
    Enum.member?(keys, value)
  end
  defp has_json_keys?(subject, _value) do
    raise ArgumentError, "Subject must be a JSON map when using have_json_keys, but it isn't: #{inspect subject}"
  end
end
