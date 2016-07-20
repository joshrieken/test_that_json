defmodule TestThatJson.Assertions do
  alias TestThatJson.Json

  def is_json_equal(subject, value) do
    handle_result!(Json.equals?(subject, value))
  end

  def has_json_keys(subject, value) do
    handle_result!(Json.has_keys?(subject, value))
  end

  def has_only_json_keys(subject, value) do
    handle_result!(Json.has_only_keys?(subject, value))
  end

  def has_json_values(subject, value) do
    handle_result!(Json.has_values?(subject, value))
  end

  def has_only_json_values(subject, value) do
    handle_result!(Json.has_only_values?(subject, value))
  end

  def has_json_properties(subject, value) do
    handle_result!(Json.has_properties?(subject, value))
  end

  def has_only_json_properties(subject, value) do
    handle_result!(Json.has_only_properties?(subject, value))
  end

  def has_json_path(subject, value) do
    handle_result!(Json.has_path?(subject, value))
  end

  def has_json_type(subject, type) do
    handle_result!(Json.has_type?(subject, type))
  end

  # PRIVATE API ##############################################

  defp handle_result!(expr) do
    case expr do
      {:error, {module, _values, message}} -> raise module, message: message
      {:error, {module, values}}           -> raise module, value: List.first(values)
      result                               -> result
    end
  end
end
