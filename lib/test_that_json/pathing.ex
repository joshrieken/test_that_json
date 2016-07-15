defmodule TestThatJson.Pathing do
  def value_at_path(value, path) when is_binary(path) do
    path_parts = String.split(path, "/")
    Enum.reduce(path_parts, value, &do_value_at_path/2)
  end
  def value_at_path(value, nil), do: value
  def value_at_path(_value, _path), do: raise TestThatJson.InvalidPathError

  # PRIVATE ##################################################

  defp do_value_at_path(path_part, map_value)  when is_map(map_value) do
    case Map.get(map_value, path_part, :error) do
      :error -> raise TestThatJson.PathNotFoundError
      value  -> value
    end
  end
  defp do_value_at_path(path_part, list_value) when is_list(list_value) do
    {index, _} = Integer.parse(path_part)
    case Enum.at(list_value, index, :error) do
      :error -> raise TestThatJson.PathNotFoundError
      value  -> value
    end
  end
  defp do_value_at_path(_path_part, _value), do: raise TestThatJson.InvalidPathError
end
