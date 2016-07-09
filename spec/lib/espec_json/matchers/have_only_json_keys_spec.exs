defmodule ESpec.Json.Matchers.HaveOnlyJsonKeysSpec do
  use ESpec

  import ESpec.Json.Matchers, only: [have_only_json_keys: 1]

  subject do: json

  context "when the subject is a JSON object" do
    let :json, do: "{\"some\": \"object\", \"another\": \"object with value\"}"

    context "when the argument is a list" do
      context "when all provided keys are present and exhaustive" do
        it do: should have_only_json_keys(["some", "another"])
      end

      context "when more than the provided keys are present" do
        it do: should_not have_only_json_keys(["some"])
      end

      context "when fewer than the provided keys are present" do
        it do: should_not have_only_json_keys(["some", "another", "yet_another"])
      end
    end

    context "when the argument is not a list" do
      let :json, do: "{\"some\": \"object\"}"

      context "when the key is present and the only one" do
        it do: should have_only_json_keys("some")
      end

      context "when the key is not present" do
        it do: should_not have_only_json_keys("other")
      end
    end
  end

  context "when the subject is not a JSON object" do
    let :json, do: "[{\"some\": \"object\"}]"

    it "raises an error" do
      raiser = fn ->
        expect json |> to(have_only_json_keys(["some"]))
      end

      expect raiser |> to(raise_exception(ArgumentError))
    end
  end
end
