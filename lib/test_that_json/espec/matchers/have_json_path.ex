defmodule TestThatJson.ESpec.Matchers.HaveJsonPath do
  use ESpec.Assertions.Interface

  alias TestThatJson.Assertions

  defp match(subject, path) do
    result = Assertions.has_json_path(subject, path)
    {result, result}
  end

  defp success_message(subject, value, _result, positive) do
    has = if positive, do: "has", else: "doesn't have"
    "`#{inspect subject}` #{has} JSON path `#{inspect value}`."
  end

  defp error_message(subject, value, _result, positive) do
    to = if positive, do: "to have", else: "not to have"
    but = if positive, do: "doesn't", else: "does"
    "Expected `#{inspect subject}` #{to} JSON path `#{inspect value}`, but it #{but}."
  end
end
