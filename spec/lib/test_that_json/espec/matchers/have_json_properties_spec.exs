defmodule TestThatJson.ESpec.HaveJsonPropertiesSpec do
  use ESpec

  import TestThatJson.ESpec.Matchers, only: [have_json_properties: 1]

  subject do: json

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
      it do: should have_json_properties(%{"some" => "property"})
      it do: should have_json_properties(%{"some" => "property", "another" => "property with value"})
      it do: should_not have_json_properties(%{"some_other" => "property"})
      it do: should_not have_json_properties(%{"some" => "property", "some_other" => "property"})
    end

    context "when the argument is not a map" do
      let :json, do: "[{\"some\": \"object\"}]"

      it "raises an error" do
        raiser = fn ->
          expect json |> to(have_json_properties(["some"]))
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
        expect json |> to(have_json_properties(["some"]))
      end

      expect raiser |> to(raise_exception(ArgumentError))
    end
  end
end
