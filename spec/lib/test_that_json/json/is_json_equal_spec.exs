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
    it do: expect is_json_equal(json, slightly_different_json) |> to(be_true)
    it do: expect is_json_equal(json, different_json) |> to(be_false)
  end

  context "when the subject is a JSON array" do
    let :json, do: "[1,2,3,4]"

    it do: expect is_json_equal(json, json) |> to(be_true)
    it do: expect is_json_equal(json, "[1,3,2,4]") |> to(be_false)
    it do: expect is_json_equal(json, "[1,2,3]") |> to(be_false)
    it do: expect is_json_equal(json, "{\"different\": \"json\"}") |> to(be_false)

    context "when the value is not valid JSON" do
      it "raises an exception" do
        raiser = fn -> expect is_json_equal(json, "invalid json") |> to(be_true) end

        expect raiser |> to(raise_exception(TestThatJson.InvalidJsonError))
      end
    end
  end

  context "when the subject is a JSON string" do
    let :json, do: "\"json string\""

    it do: expect is_json_equal(json, json) |> to(be_true)
    it do: expect is_json_equal(json, "\"josn string\"") |> to(be_false)
  end

  context "when the subject is not valid JSON" do
    let :json, do: "invalid"

    context "when the value is not valid JSON" do
      it "raises an exception" do
        raiser = fn -> expect is_json_equal(json, "invalid json") |> to(be_true) end

        expect raiser |> to(raise_exception(TestThatJson.InvalidJsonError))
      end
    end
  end
end
