defmodule TestThatJson.Assertions.HasOnlyJsonKeysSpec do
  use ESpec

  import TestThatJson.Assertions, only: [has_only_json_keys: 2]

  context "when the subject is a JSON object" do
    let :json, do: "{\"some\": \"object\", \"another\": \"object with value\"}"

    context "when the argument is a list" do
      it do: expect has_only_json_keys(json, ["some", "another"]) |> to(be_true)
      it do: expect has_only_json_keys(json, ["some"]) |> to(be_false)
      it do: expect has_only_json_keys(json, ["some", "another", "yet_another"]) |> to(be_false)
    end

    context "when the argument is not a list" do
      let :json, do: "{\"some\": \"object\"}"

      it do: expect has_only_json_keys(json, "some") |> to(be_true)
      it do: expect has_only_json_keys(json, "other") |> to(be_false)
    end

    context "when the value is neither a list or a string" do
      let :json, do: "[{\"some\": \"object\"}]"

      it "raises an error" do
        raiser = fn ->
          expect has_only_json_keys(json, %{"a" => "map"}) |> to(be_true)
        end

        expect raiser |> to(raise_exception(ArgumentError))
      end
    end
  end

  context "when the subject is not a JSON object" do
    let :json, do: "[{\"some\": \"object\"}]"

    it "raises an error" do
      raiser = fn ->
        expect has_only_json_keys(json, ["some"]) |> to(be_true)
      end

      expect raiser |> to(raise_exception(ArgumentError))
    end
  end
end
