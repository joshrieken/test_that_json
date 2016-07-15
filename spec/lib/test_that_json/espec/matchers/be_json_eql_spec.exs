defmodule TestThatJson.ESpec.Matchers.BeJsonEqlSpec do
  use ESpec

  import TestThatJson.ESpec.Matchers, only: [be_json_eql: 1]

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

    it do: should be_json_eql(json)
    it do: should be_json_eql(slightly_different_json)
    it do: should_not be_json_eql(different_json)
  end

  context "when the subject is a JSON array" do
    let :json, do: "[1,2,3,4]"

    it do: should be_json_eql(json)
    it do: should_not be_json_eql("[1,3,2,4]")
    it do: should_not be_json_eql("[1,2,3]")
    it do: should_not be_json_eql("{\"different\": \"json\"}")

    context "when the value is not valid JSON" do
      it "raises an exception" do
        raiser = fn -> expect subject |> to(be_json_eql("invalid json")) end

        expect raiser |> to(raise_exception(TestThatJson.InvalidJsonError))
      end
    end
  end

  context "when the subject is a JSON string" do
    let :json, do: "\"json string\""

    it do: should be_json_eql(json)
    it do: should_not be_json_eql("\"josn string\"")
  end

  context "when the subject is not valid JSON" do
    let :json, do: "invalid"

    context "when the value is not valid JSON" do
      it "raises an exception" do
        raiser = fn -> expect subject |> to(be_json_eql("invalid json")) end

        expect raiser |> to(raise_exception(TestThatJson.InvalidJsonError))
      end
    end
  end
end
