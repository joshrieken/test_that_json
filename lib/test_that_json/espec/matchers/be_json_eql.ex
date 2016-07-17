defmodule TestThatJson.ESpec.Matchers.BeJsonEql do
  use ESpec.Assertions.Interface

  alias TestThatJson.Assertions

  defp match(subject, value) when is_binary(value) do
    result = Assertions.is_json_eql(subject, value)
    {result, result}
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
end
