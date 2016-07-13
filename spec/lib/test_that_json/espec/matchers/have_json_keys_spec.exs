defmodule TestThatJson.ESpec.Matchers.HaveJsonKeysSpec do
  use ESpec

  import TestThatJson.ESpec.Matchers, only: [have_json_keys: 1]

  subject do: json

  context "when the subject is a JSON object" do
    let :json, do: "{\"some\": \"object\", \"another\": \"object with value\"}"

    context "when the value is a list" do
      it do: should have_json_keys(["some", "another"])
      it do: should_not have_json_keys(["some", "another", "yet_another"])
    end

    context "when the value is a string" do
      it do: should have_json_keys("some")
      it do: should_not have_json_keys("other")
    end

    context "when the value is neither a list or a string" do
      let :json, do: "[{\"some\": \"object\"}]"

      it "raises an error" do
        raiser = fn ->
          expect json |> to(have_json_keys(%{"a" => "map"}))
        end

        expect raiser |> to(raise_exception(ArgumentError))
      end
    end
  end

  context "when the subject is not a JSON object" do
    let :json, do: "[{\"some\": \"object\"}]"

    it "raises an error" do
      raiser = fn ->
        expect json |> to(have_json_keys(["some"]))
      end

      expect raiser |> to(raise_exception(ArgumentError))
    end
  end
end
