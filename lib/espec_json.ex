defmodule ESpec.Json do
  defmacro __using__(_) do
    quote do
      import ESpec.Json.Configuration
      import ESpec.Json.Matchers
    end
  end
end
