defmodule TestThatJson.InvalidPathError do
  defexception [:message]

  def exception(attrs) do
    value   = attrs[:value]
    message = attrs[:message] || "improperly formatted path: #{inspect value}"
    %TestThatJson.InvalidPathError{message: message}
  end
end

defmodule TestThatJson.PathNotFoundError do
  defexception [:message]

  def exception(attrs) do
    value   = attrs[:value]
    message = attrs[:message] || "path not found: #{inspect value}"
    %TestThatJson.PathNotFoundError{message: message}
  end
end

defmodule TestThatJson.InvalidJsonError do
  defexception [:message]

  def exception(attrs) do
    value   = attrs[:value]
    message = attrs[:message] || "unparseable JSON: #{inspect value}"
    %TestThatJson.InvalidJsonError{message: message}
  end
end

defmodule TestThatJson.JsonEncodingError do
  defexception [:message]

  def exception(attrs) do
    value   = attrs[:value]
    message = attrs[:message] || "unable to JSON encode value: #{inspect value}"
    %TestThatJson.JsonEncodingError{message: message}
  end
end
