defmodule ESpec.Json.Matchers.HaveJsonKeysSpec do
  use ESpec

  import ESpec.Json.Matchers, only: [have_json_keys: 1]

  subject do: json

  context "when the subject is a JSON object" do
    let :json, do: "{\"some\": \"object\", \"another\": \"object with value\"}"

    context "when the argument is a list" do
      context "when all keys are present" do
        it do: should have_json_keys(["some", "another"])
      end

      context "when not all keys are present" do
        it do: should_not have_json_keys(["some", "another", "yet_another"])
      end
    end

    context "when the argument is not a list" do
      context "when the key is present" do
        it do: should have_json_keys("some")
      end

      context "when the key is not present" do
        it do: should_not have_json_keys("other")
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
