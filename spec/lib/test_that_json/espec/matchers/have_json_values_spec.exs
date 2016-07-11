defmodule TestThatJson.ESpec.Matchers.HaveJsonValuesSpec do
  use ESpec

  import TestThatJson.ESpec.Matchers, only: [have_json_values: 1]

  subject do: json

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

    context "when the value is a map" do
      it do: should have_json_values(%{"nested" => "object y'all"})
      it do: should_not have_json_values(%{"missing" => "object"})
    end

    context "when the value is a list" do
      it do: should have_json_values(["object", "key with value"])
      it do: should_not have_json_values(["object", "key with value", "yet_another"])
    end

    context "when the value is a string" do
      it do: should have_json_values("object")
      it do: should_not have_json_values("some")
      it do: should have_json_values("{\"nested\": \"object y'all\"}")
    end
  end

  context "when the subject is a JSON array" do
    let :json do
      """
      [
        {
          "some": "object",
          "another": "key with value"
        },
        {
          "another": "object"
        },
        ["a list with a string"],
        "some string"
      ]
      """
    end

    context "when the value is a list" do
      it do: should have_json_values([["a list with a string"]])
    end

    context "when the value is a map" do
      it do: should have_json_values(%{"some" => "object", "another" => "key with value"})
      it do: should_not have_json_values(%{"some_other" => "object"})
    end

    context "when the value is a string" do
      context "when the string is valid JSON" do
        it do: should have_json_values("[\"a list with a string\"]")
        it do: should_not have_json_values("\"a list with a string\"")
      end

      context "when the string is not JSON" do
        it do: should have_json_values("some string")
        it do: should_not have_json_values("some other string")
      end
    end
  end

  context "when the subject is a JSON string" do
    let :json, do: "\"string\""

    context "when the value is a JSON string" do
      it do: should have_json_values("\"string\"")
      it do: should_not have_json_values("\"another string\"")
    end

    context "when the value is a string but not JSON" do
      it do: should have_json_values("string")
      it do: should_not have_json_values("another string")
    end
  end
end
