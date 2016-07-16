defmodule TestThatJson.ESpec.Matchers.HaveOnlyJsonKeys do
  use ESpec.Assertions.Interface

  alias TestThatJson.Json

  defp match(subject, value) do
    case Json.has_only_keys?(subject, value) do
      {:error, {module, _args, message}} -> raise module, message
      result                             -> {result, result}
    end
  end

  defp success_message(subject, value, _result, positive) do
    has = if positive, do: "has only", else: "doesn't have only"
    "`#{inspect subject}` #{has} only JSON keys `#{inspect value}`."
  end

  defp error_message(subject, value, _result, positive) do
    to = if positive, do: "to have only", else: "not to have only"
    but = if positive, do: "doesn't", else: "does"
    "Expected `#{inspect subject}` #{to} only JSON keys `#{inspect value}`, but it #{but}."
  end
end
