defmodule ESpec.Json.Matchers.BeJsonEqlSpec do
  use ESpec

  import ESpec.Json.Matchers, only: [be_json_eql: 1]

  describe "be_json_eql" do
    subject do: json

    context "with valid JSON as the subject" do
      let :json do
        path = "spec/support/json/valid.json"
        {:ok, json} = File.read(path)
        json
      end

      context "compared against exactly the same JSON" do
        let :same_json do
          path = "spec/support/json/valid.json"
          {:ok, json} = File.read(path)
          json
        end

        it do: should be_json_eql(same_json)
      end

      context "compared against the same JSON with keys in a different order" do
        let :json_different_order do
          path = "spec/support/json/valid_different_key_order.json"
          {:ok, json} = File.read(path)
          json
        end

        it do: should be_json_eql(json_different_order)
      end

      context "compared against JSON that is slightly different" do
        let :slightly_different_json do
          path = "spec/support/json/valid_slightly_different.json"
          {:ok, json} = File.read(path)
          json
        end

        it do: should_not be_json_eql(slightly_different_json)
      end

      context "compared against JSON that is slightly different" do
        let :very_different_json do
          path = "spec/support/json/valid_very_different.json"
          {:ok, json} = File.read(path)
          json
        end

        it do: should_not be_json_eql(very_different_json)
      end

      context "compared against invalid JSON" do
        let :invalid_json do
          path = "spec/support/json/invalid.json"
          {:ok, json} = File.read(path)
          json
        end

        it "raises an exception" do
          raiser = fn -> be_json_eql(invalid_json) end

          expect raiser.() |> to(raise_exception)
        end
      end
    end
  end
end
