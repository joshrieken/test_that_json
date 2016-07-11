defmodule TestThatJson.ExclusionSpec do
  use ESpec

  alias TestThatJson.Configuration
  alias TestThatJson.Exclusion

  describe "exclude_keys" do
    subject do: exclusion_result

    let :exclusion_result, do: Exclusion.exclude_keys(value)

    let :map_value do
      %{
        "id" => "1234",
        "inserted_at" => "5678",
        "user" => "Leeroy",
      }
    end

    context "when the value is a list" do
      subject do: Enum.at(exclusion_result, 0)

      let :value do
        [
          Map.merge(map_value, %{
            "email" => "leeroy@example.com",
          })
        ]
      end

      it do: should have_key("user")
      it do: should_not have_key("id")
      it do: should_not have_key("inserted_at")
    end

    context "when the value is a map" do
      let :value, do: map_value

      it do: should have_key("user")
      it do: should_not have_key("id")
      it do: should_not have_key("inserted_at")
    end

    context "when the value is a non-list, non-map" do
      let :value, do: "value"

      it do: should eq(value)
    end
  end

  describe "excluded_keys" do
    subject do: Exclusion.excluded_keys

    before do
      allow Configuration |> to(accept(:excluded_keys, fn -> [] end))
      subject
    end

    it "calls the correct function" do
      expect Configuration |> to(accepted(:excluded_keys))
    end
  end
end
