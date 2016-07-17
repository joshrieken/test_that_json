defmodule TestThatJson.Assertions.HasJsonPathSpec do
  use ESpec

  import TestThatJson.Assertions, only: [has_json_path: 2]

  context "when the subject is a JSON object" do
    context "when that object is shallow" do
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

      it do: expect has_json_path(json, "some") |> to(be_true)
      it do: expect has_json_path(json, "key_with_object") |> to(be_true)
      it do: expect has_json_path(json, "does_not_exist") |> to(be_false)
    end

    context "when that object has nesting" do
      let :json do
        """
        {
          "nested": {
            "inner": {
              "another": {
                "array": [1,2,3],
                "innermost": "property"
              }
            }
          }
        }
        """
      end

      it do: expect has_json_path(json, "nested/inner/another/array/2") |> to(be_true)
      it do: expect has_json_path(json, "nested/inner/another/innermost") |> to(be_true)
      it do: expect has_json_path(json, "nested/inner/another/array/8") |> to(be_false)
      it do: expect has_json_path(json, "nested/inner/another/inner") |> to(be_false)
    end
  end

  context "when the subject is a JSON array" do
    let :json do
      """
      [
       1,2,3
      ]
      """
    end

    it do: expect has_json_path(json, "1") |> to(be_true)
    it do: expect has_json_path(json, "-1") |> to(be_true)
    it do: expect has_json_path(json, "-4") |> to(be_false)
    it do: expect has_json_path(json, "3") |> to(be_false)
    it do: expect has_json_path(json, "6") |> to(be_false)
  end

  context "when the subject is not a JSON object or array" do
    let :json, do: "\"json string\""

    it "raises an error" do
      raiser = fn ->
        expect has_json_path(json, "some/path") |> to(be_true)
      end

      expect raiser |> to(raise_exception(TestThatJson.InvalidPathError))
    end
  end
end
