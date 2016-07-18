defmodule TestThatJson.Assertions.IsJsonEqualSpec do
  use ESpec

  import TestThatJson.Assertions, only: [is_json_equal: 2]

  context "when the subject is a JSON object" do
    let :json do
      """
      {
        "some": "object",
        "another": "key with value",
        "key_with_object": {
          "nested": "object y'all"
        }
      }
      """
    end

    let :slightly_different_json do
      """
      {
        "another": "key with value",
        "some": "object",
        "key_with_object": {
          "nested": "object y'all"
        }
      }
      """
    end

    let :different_json do
      """
      {
        "some": "object",
        "key_with_object": {
          "nested": "object y'all"
        }
      }
      """
    end

    it do: expect is_json_equal(json, json) |> to(be_true)
    it do: expect is_json_equal(json, %{
      "some" => "object",
      "another" => "key with value",
      "key_with_object" => %{"nested" => "object y'all"}})
      |> to(be_true)
    it do: expect is_json_equal(json, slightly_different_json) |> to(be_true)
    it do: expect is_json_equal(json, different_json) |> to(be_false)
  end

  context "when the subject is a JSON array" do
    let :json, do: "[1,2,3,4]"

    it do: expect is_json_equal(json, json) |> to(be_true)
    it do: expect is_json_equal(json, [1,2,3,4]) |> to(be_true)
    it do: expect is_json_equal(json, "[1,3,2,4]") |> to(be_false)
    it do: expect is_json_equal(json, "[1,2,3]") |> to(be_false)
    it do: expect is_json_equal(json, "{\"different\": \"json\"}") |> to(be_false)
  end

  context "when the subject is a JSON string" do
    let :json, do: "\"json string\""

    it do: expect is_json_equal(json, json) |> to(be_true)
    it do: expect is_json_equal(json, "json string") |> to(be_true)
    it do: expect is_json_equal(json, "\"josn string\"") |> to(be_false)
  end
end
