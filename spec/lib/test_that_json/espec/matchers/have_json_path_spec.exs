defmodule HaveJsonPathSpec do
  use ESpec

  import TestThatJson.ESpec.Matchers, only: [have_json_path: 1]

  subject do: json

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

      it do: should have_json_path("some")
      it do: should have_json_path("key_with_object")
      it do: should_not have_json_path("does_not_exist")
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

      it do: should have_json_path("nested/inner/another/array/2")
      it do: should have_json_path("nested/inner/another/innermost")
      it do: should_not have_json_path("nested/inner/another/array/8")
      it do: should_not have_json_path("nested/inner/another/inner")
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

    it do: should have_json_path("1")
    it do: should have_json_path("-1")
    it do: should_not have_json_path("-4")
    it do: should_not have_json_path("3")
    it do: should_not have_json_path("6")
  end

  context "when the subject is not a JSON object or array" do
    let :json, do: "\"json string\""

    it "raises an error" do
      raiser = fn ->
        expect json |> to(have_json_path("some/path"))
      end

      expect raiser |> to(raise_exception(TestThatJson.InvalidPathError))
    end
  end
end
