defmodule TestThatJson.Helpers.HaveJsonValuesSpec do
  use ESpec

  import TestThatJson.Helpers, only: [has_json_values: 2]

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
      it do: expect has_json_values(json, %{"nested" => "object y'all"}) |> to(be_true)
      it do: expect has_json_values(json, %{"missing" => "object"}) |> to(be_false)
    end

    context "when the value is a list" do
      it do: expect has_json_values(json, ["object", "key with value"]) |> to(be_true)
      it do: expect has_json_values(json, ["object", "key with value", "yet_another"]) |> to(be_false)
    end

    context "when the value is a string" do
      it do: expect has_json_values(json, "object") |> to(be_true)
      it do: expect has_json_values(json, "some") |> to(be_false)
      it do: expect has_json_values(json, "{\"nested\": \"object y'all\"}") |> to(be_true)
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
      it do: expect has_json_values(json, [["a list with a string"]]) |> to(be_true)
    end

    context "when the value is a map" do
      it do: expect has_json_values(json, %{"some" => "object", "another" => "key with value"}) |> to(be_true)
      it do: expect has_json_values(json, %{"some_other" => "object"}) |> to(be_false)
    end

    context "when the value is a string" do
      context "when the string is valid JSON" do
        it do: expect has_json_values(json, "[\"a list with a string\"]") |> to(be_true)
        it do: expect has_json_values(json, "\"a list with a string\"") |> to(be_false)
      end

      context "when the string is not JSON" do
        it do: expect has_json_values(json, "some string") |> to(be_true)
        it do: expect has_json_values(json, "some other string") |> to(be_false)
      end
    end
  end

  context "when the subject is a JSON string" do
    let :json, do: "\"string\""

    context "when the value is a JSON string" do
      it do: expect has_json_values(json, "\"string\"") |> to(be_true)
      it do: expect has_json_values(json, "\"another string\"") |> to(be_false)
    end

    context "when the value is a string but not JSON" do
      it do: expect has_json_values(json, "string") |> to(be_true)
      it do: expect has_json_values(json, "another string") |> to(be_false)
    end
  end
end
