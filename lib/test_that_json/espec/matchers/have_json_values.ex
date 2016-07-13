defmodule TestThatJson.ESpec.Matchers.HaveJsonValues do
  use ESpec.Assertions.Interface

  alias TestThatJson.Json

  defp match(subject, value) do
    case Json.has_values?(subject, value) do
      {:error, module, _args, message} -> raise module, message
      result                           -> {result, result}
    end
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
end
