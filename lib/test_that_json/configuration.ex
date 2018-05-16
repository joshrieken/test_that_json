defmodule TestThatJson.Configuration do
  def excluded_keys do
    Application.get_env(:test_that_json, :excluded_keys, default_excluded_keys())
  end

  def default_excluded_keys, do: ~w(id inserted_at updated_at)
end
