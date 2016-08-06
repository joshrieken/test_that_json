defmodule TestThatJson.Helpers.HasJsonSizeSpec do
  use ESpec

  import TestThatJson.Helpers, only: [has_json_size: 2]

  context "when the subject is a JSON object" do
    let :json do
      """
      {
        "some": "property",
        "another": "property with value"
      }
      """
    end

    it do: expect has_json_size(json, 2) |> to(be_true)
    it do: expect has_json_size(json, 5) |> to(be_false)
    it do: expect has_json_size(json, 0) |> to(be_false)
  end

  context "when the subject is a JSON array" do
    let :json, do: "[1,2]"

    it do: expect has_json_size(json, 2) |> to(be_true)
    it do: expect has_json_size(json, 1) |> to(be_false)
  end

  context "when the subject is a JSON string" do
    let :json, do: "\"string\""

    it "raises an error" do
      raiser = fn ->
        expect has_json_size(json, 2) |> to(be_true)
      end

      expect raiser |> to(raise_exception(ArgumentError))
    end
  end

  context "when the size is not an integer" do
    let :json, do: "[1,2,3]"

    it "raises an error" do
      raiser = fn ->
        expect has_json_size(json, "0") |> to(be_true)
      end

      expect raiser |> to(raise_exception(ArgumentError))
    end
  end
end
