defmodule TestThatJson.AssertionsTest do
  use ExUnit.Case, async: true

  import TestThatJson.Assertions

  test "is_json_equal" do
    json = "[1,2,3]"

    assert is_json_equal(json, json)
  end

  test "has_json_keys" do
    json = """
    {
      "key1": "value",
      "key2": "data"
    }
    """

    assert has_json_keys(json, ["key1", "key2"])
  end

  test "has_only_json_keys" do
    json = """
    {
      "key1": "value",
      "key2": "data"
    }
    """

    assert has_only_json_keys(json, ["key1", "key2"])
  end

  test "has_json_values" do
    json = """
    {
      "key1": "value",
      "key2": "data"
    }
    """

    assert has_json_values(json, ["value", "data"])
  end

  test "has_only_json_values" do
    json = """
    {
      "key1": "value",
      "key2": "data"
    }
    """

    assert has_only_json_values(json, ["value", "data"])
  end

  test "has_json_properties" do
    json = """
    {
      "key1": "value",
      "key2": "data"
    }
    """

    assert has_json_properties(json, %{"key1" => "value", "key2" => "data"})
  end

  test "has_only_json_properties" do
    json = """
    {
      "key1": "value",
      "key2": "data"
    }
    """

    assert has_only_json_properties(json, %{"key1" => "value", "key2" => "data"})
  end

  test "has_json_path" do
    json = """
    {
      "key1": "value",
      "key2": "data"
    }
    """

    assert has_json_path(json, "key1")
  end

  test "has_json_type" do
    json = """
    {
      "key1": "value",
      "key2": "data"
    }
    """

    assert has_json_type(json, :object)
  end

  test "has_json_size" do
    json = """
    {
      "key1": "value",
      "key2": "data"
    }
    """

    assert has_json_size(json, 2)
  end
end

