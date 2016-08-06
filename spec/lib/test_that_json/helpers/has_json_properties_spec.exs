defmodule TestThatJson.Helpers.HasJsonPropertiesSpec do
  use ESpec

  import TestThatJson.Helpers, only: [has_json_properties: 2]

  context "when the subject is a JSON object" do
    let :json do
      """
      {
        "some": "property",
        "another": "property with value"
      }
      """
    end

    context "when the argument is a map" do
      it do: expect has_json_properties(json, %{"some" => "property"}) |> to(be_true)
      it do: expect has_json_properties(json, %{"some" => "property", "another" => "property with value"}) |> to(be_true)
      it do: expect has_json_properties(json, %{"some_other" => "property"}) |> to(be_false)
      it do: expect has_json_properties(json, %{"some" => "property", "some_other" => "property"}) |> to(be_false)
    end

    context "when the argument is not a map" do
      let :json, do: "[{\"some\": \"object\"}]"

      it "raises an error" do
        raiser = fn ->
          expect json |> to(has_json_properties(json, ["some"]))
        end

        expect raiser |> to(raise_exception(ArgumentError))
      end
    end
  end

  context "when the subject is not a JSON object" do
    let :json do
      """
      {
        "some": "property",
        "another": "property with value"
      }
      """
    end

    it "raises an error" do
      raiser = fn ->
        expect has_json_properties(json, ["some"]) |> to(be_true)
      end

      expect raiser |> to(raise_exception(ArgumentError))
    end
  end
end
