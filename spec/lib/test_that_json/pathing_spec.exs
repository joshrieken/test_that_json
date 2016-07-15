defmodule TestThatJson.PathingSpec do
  use ESpec

  alias TestThatJson.Pathing

  describe "value_at_path" do
    subject do: Pathing.value_at_path(value, path)

    context "when the path is nil" do
      let :value, do: %{"some" => "map"}
      let :path, do: nil

      it do: should eq(value)
    end

    context "when the value is a map" do
      let :value do
        %{
          "id" => "1234",
          "inserted_at" => "5678",
          "user" => "Leeroy",
        }
      end

      let :path,  do: "id"

      it do: should eq("1234")

      context "when that map has a list as a value" do
        let :value do
          %{
            "id" => ["1234"],
            "inserted_at" => "5678",
            "user" => "Leeroy",
          }
        end

        let :path,  do: "id/0"

        it do: should eq("1234")
      end
    end

    context "when the value is a list" do
      let :value do
        [
          "5678",
          "9876",
        ]
      end

      let :path,  do: "1"

      it do: should eq("9876")
    end

    context "when the value is a non-list, non-map" do
      let :value do
        "hi"
      end

      let :path,  do: "1"

      it "raises an error" do
        raiser = fn ->
          expect subject |> to(eq(""))
        end

        expect raiser |> to(raise_exception(ArgumentError))
      end
    end
  end
end
