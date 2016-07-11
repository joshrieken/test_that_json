defmodule TestThatJson.Configuration do
  @default_excluded_keys ~w(id inserted_at updated_at)

  def excluded_keys do
    Application.get_env(:test_that_json, :excluded_keys, @default_excluded_keys)
  end
end
