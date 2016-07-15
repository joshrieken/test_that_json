defmodule TestThatJson.HelpersSpec do
  use ESpec

  alias TestThatJson.Helpers

  describe "parse_json" do
    subject Helpers.parse_json(json)

    context "when the value is valid JSON" do
      let :json do
        """
        {
          "some": "object",
          "another": "key with value",
          "key_with_object": {
            "nested": "object y'all"
          }
        }
        """
      end

      let :parsed_value do
        %{
          "some" => "object",
          "another" => "key with value",
          "key_with_object" => %{
            "nested" => "object y'all"
          }
        }
      end

      it do: should eq({:ok, parsed_value})
    end

    context "when the value is not valid JSON" do
      let :json, do: "invalid"

      it do: should be_error_result
    end
  end

  describe "parse_json!" do
    subject Helpers.parse_json!(json)

    context "when the value is valid JSON" do
      let :json do
        """
        {
          "some": "object",
          "another": "key with value",
          "key_with_object": {
            "nested": "object y'all"
          }
        }
        """
      end

      let :parsed_value do
        %{
          "some" => "object",
          "another" => "key with value",
          "key_with_object" => %{
            "nested" => "object y'all"
          }
        }
      end

      it do: should eq(parsed_value)
    end

    context "when the value is not valid JSON" do
      let :json, do: "invalid"

      it "raises an error" do
        raiser = fn ->
          expect subject |> to(eq(%{"a" => "map"}))
        end

        expect raiser |> to(raise_exception(TestThatJson.InvalidJsonError))
      end
    end
  end

  describe "normalize_json"

  describe "generate_normalized_json"

  describe "load_json"
end
