defmodule TestThatJson.InvalidPathError do
  defexception message: "The provided path is not correctly formatted"
end

defmodule TestThatJson.PathNotFoundError do
  defexception message: "The provided path was not found"
end

defmodule TestThatJson.InvalidJsonError do
  defexception message: "The provided JSON could not be parsed"
end
