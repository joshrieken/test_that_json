defmodule ESpec.Json.Matchers.BeJsonEql do
  use ESpec.Assertions.Interface

  import ESpec.Json.Exclusion
  import ESpec.Json.Parsing

  defp match(subject, value) when is_binary(value) do
    normalized_subject = normalize_json(subject)
    normalized_value   = normalize_json(value)

    result = (normalized_subject == normalized_value)

    {result, value}
  end

  defp success_message(subject, value, _result, positive) do
    to = if positive, do: "equals", else: "doesn't equal"
    "`#{inspect subject}` #{to} `#{inspect value}`."
  end

  defp error_message(subject, value, _result, positive) do
    to = if positive, do: "to equal", else: "not to equal"
    but = if positive, do: "doesn't", else: "does"
    "Expected `#{inspect subject}` #{to} `#{inspect value}`, but it #{but}."
  end

  defp normalize_json(json) do
    exclude_keys(parse!(json))
  end
end
