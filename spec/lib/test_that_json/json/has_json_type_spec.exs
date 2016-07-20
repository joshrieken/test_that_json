defmodule TestThatJson.Assertions.HasJsonTypeSpec do
  use ESpec

  import TestThatJson.Assertions, only: [has_json_type: 2]

  context "when the subject is a JSON object" do
    let :json do
      """
      {
        "some": "property",
        "another": "property with value"
      }
      """
    end

    it do: expect has_json_type(json, :object) |> to(be_true)
    it do: expect has_json_type(json, :array) |> to(be_false)
  end

  context "when the subject is a JSON array" do
    let :json do
      """
      [
        {
          "some": "property",
          "another": "property with value"
        },
        {
          "yet_another" :"property"
        }
      ]
      """
    end

    it do: expect has_json_type(json, :array) |> to(be_true)
    it do: expect has_json_type(json, :object) |> to(be_false)
  end

  context "when the subject is a JSON string" do
    let :json, do: "\"string\""

    it do: expect has_json_type(json, :string) |> to(be_true)
    it do: expect has_json_type(json, :array) |> to(be_false)
    it do: expect has_json_type(json, :object) |> to(be_false)
  end

  context "when the subject is a JSON integer" do
    let :json, do: "0"

    it do: expect has_json_type(json, :number) |> to(be_true)
    it do: expect has_json_type(json, :integer) |> to(be_true)
    it do: expect has_json_type(json, :float) |> to(be_false)
    it do: expect has_json_type(json, :string) |> to(be_false)
  end

  context "when the subject is a JSON float" do
    let :json, do: "1.1"

    it do: expect has_json_type(json, :number) |> to(be_true)
    it do: expect has_json_type(json, :float) |> to(be_true)
    it do: expect has_json_type(json, :integer) |> to(be_false)
    it do: expect has_json_type(json, :string) |> to(be_false)
  end

  context "when the subject is JSON null" do
    let :json, do: "null"

    it do: expect has_json_type(json, :null) |> to(be_true)
    it do: expect has_json_type(json, :string) |> to(be_false)
  end

  context "when the subject is JSON boolean" do
    let :json, do: "true"

    it do: expect has_json_type(json, :boolean) |> to(be_true)
    it do: expect has_json_type(json, :null) |> to(be_false)
    it do: expect has_json_type(json, :string) |> to(be_false)
  end

  context "when the type is not an atom" do
    let :json, do: "true"

    it "raises an error" do
      raiser = fn ->
        expect has_json_type(json, "some") |> to(be_true)
      end

      expect raiser |> to(raise_exception(ArgumentError))
    end
  end

  context "when the type is not supported" do
    let :json, do: "true"

    it "raises an error" do
      raiser = fn ->
        expect has_json_type(json, :bloop) |> to(be_true)
      end

      expect raiser |> to(raise_exception(ArgumentError))
    end
  end
end
