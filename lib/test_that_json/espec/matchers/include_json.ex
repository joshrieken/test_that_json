# defmodule TestThatJson.ESpec.Matchers.IncludeJson do
#   use ESpec.Assertions.Interface
#
#   import TestThatJson.Exclusion
#   import TestThatJson.Parsing
#
#   defp match(subject, value) when is_binary(value) do
#     parsed_subject = parse!(subject)
#     parsed_value   = parse!(value)
#     normalized_subject = exclude_keys(parsed_subject)
#     normalized_value   = exclude_keys(parsed_value)
#
#     result = subject_includes_value?(normalized_subject, normalized_value)
#
#     {result, result}
#   end
#
#   defp success_message(subject, value, _result, positive) do
#     to = if positive, do: "includes", else: "doesn't include"
#     "`#{inspect subject}` #{to} `#{inspect value}`."
#   end
#
#   defp error_message(subject, value, _result, positive) do
#     to = if positive, do: "to include", else: "not to include"
#     but = if positive, do: "doesn't", else: "does"
#     "Expected `#{inspect subject}` #{to} `#{inspect value}`, but it #{but}."
#   end
#
#   defp subject_includes_value?(map_subject, list_value) when is_map(map_subject) and is_list(list_value), do: false
#   defp subject_includes_value?(map_subject, map_value) when is_map(map_subject) and is_map(map_value) do
#     merged = Map.merge(map_subject, map_value)
#     map_subject == merged
#   end
#   defp subject_includes_value?(map_subject, _value) when is_map(map_subject), do: false
#   defp subject_includes_value?(list_subject, list_value) when is_list(list_subject) and is_list(list_value) and list_subject == list_value, do: true
#   defp subject_includes_value?(list_subject, list_value) when is_list(list_subject) and is_list(list_value) do
#     Enum.any?(list_value, &subject_includes_value?(list_subject, &1))
#   end
#   defp subject_includes_value?(list_subject, value) when is_list(list_subject) do
#     Enum.member?(list_subject, value)
#   end
#   defp subject_includes_value?(_subject, list_value) when is_list(list_value), do: false
#   defp subject_includes_value?(_subject, map_value) when is_map(map_value),    do: false
#   defp subject_includes_value?(subject, value), do: subject == value
# end
