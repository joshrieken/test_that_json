defmodule TestThatJson.ESpec.Matchers.HaveOnlyJsonProperties do
  use ESpec.Assertions.Interface

  alias TestThatJson.Assertions

  defp match(subject, value) do
    result = Assertions.has_only_json_properties(subject, value)
    {result, result}
  end

  defp success_message(subject, value, _result, positive) do
    has = if positive, do: "has", else: "doesn't have"
    "`#{inspect subject}` #{has} only JSON properties `#{inspect value}`."
  end

  defp error_message(subject, value, _result, positive) do
    to = if positive, do: "to have", else: "not to have"
    but = if positive, do: "doesn't", else: "does"
    "Expected `#{inspect subject}` #{to} only JSON properties `#{inspect value}`, but it #{but}."
  end
end
