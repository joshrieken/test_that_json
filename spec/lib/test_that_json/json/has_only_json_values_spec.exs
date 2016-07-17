defmodule TestThatJson.Assertions.HaveOnlyJsonValuesSpec do
  use ESpec

  import TestThatJson.Assertions, only: [has_only_json_values: 2]

  context "when the subject is a JSON object" do
    context "when the value is a map" do
      let :json do
        """
        {
          "key_with_object": {
            "nested": "object y'all"
          }
        }
        """
      end

      it do: expect has_only_json_values(json, %{"nested" => "object y'all"}) |> to(be_true)
      it do: expect has_only_json_values(json, %{"missing" => "object"}) |> to(be_false)
    end

    context "when the value is a list" do
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

      context "when all provided values are present and exhaustive" do
        it do: expect has_only_json_values(json, ["object", "key with value", %{"nested" => "object y'all"}]) |> to(be_true)
      end

      context "when more than the provided values are present" do
        it do: expect has_only_json_values(json, ["object"]) |> to(be_false)
      end

      context "when fewer than the provided values are present" do
        it do: expect has_only_json_values(json, ["object", "key with value", "yet_another", %{"nested" => "object y'all"}]) |> to(be_false)
      end
    end

    context "when the value is a string" do
      context "when there is exactly one string value" do
        let :json do
          """
          {
            "some": "object"
          }
          """
        end

        it do: expect has_only_json_values(json, "object") |> to(be_true)
      end

      context "when there is more than one string value" do
        let :json do
          """
          {
            "some": "property",
            "this is": "another property"
          }
          """
        end

        it do: expect has_only_json_values(json, "property") |> to(be_false)
        it do: expect has_only_json_values(json, "another property") |> to(be_false)
      end
    end
  end

  context "when the subject is a JSON array" do
    context "when the value is a list" do
      let :json do
        """
        [
          {
            "some": "object",
            "another": "key with value"
          },
          {
            "another": "object"
          },
          ["a list with a string"],
          "some string"
        ]
        """
      end

      it do: expect has_only_json_values(json, [
        %{"some" => "object", "another" => "key with value"},
        %{"another" => "object"},
        ["a list with a string"],
        "some string",
      ]) |> to(be_true)

      it do: expect has_only_json_values(json, [
        %{"another" => "object"},
        %{"some" => "object", "another" => "key with value"},
        ["a list with a string"],
        "some string",
      ]) |> to(be_false)

      it do: expect has_only_json_values(json, [
        %{"another" => "object"},
        ["a list with a string"],
        "some string",
      ]) |> to(be_false)

      it do: expect has_only_json_values(json, [
        %{"some" => "object", "another" => "key with value"},
        %{"another" => "object"},
        ["a list with a string"],
        "some string",
        "another string",
      ]) |> to(be_false)
    end

    context "when the value is a map" do
      let :json do
        """
        [
          {
            "some": "object",
            "another": "key with value"
          }
        ]
        """
      end

      it do: expect has_only_json_values(json, %{"some" => "object", "another" => "key with value"}) |> to(be_true)
      it do: expect has_only_json_values(json, %{"some_other" => "object"}) |> to(be_false)
    end

    context "when the value is a string" do
      context "when the string is valid JSON" do
        let :json do
          """
          [
            ["a list with a string"]
          ]
          """
        end

        it do: expect has_only_json_values(json, "[\"a list with a string\"]") |> to(be_true)
        it do: expect has_only_json_values(json, "\"a list with a string\"") |> to(be_false)
      end

      context "when the string is not JSON" do
        let :json do
          """
          [
            "a list with a string"
          ]
          """
        end

        it do: expect has_only_json_values(json, "a list with a string") |> to(be_true)
        it do: expect has_only_json_values(json, "some other string") |> to(be_false)
      end
    end
  end

  context "when the subject is a JSON string" do
    let :json, do: "\"string\""

    context "when the value is a JSON string" do
      it do: expect has_only_json_values(json, "\"string\"") |> to(be_true)
      it do: expect has_only_json_values(json, "\"another string\"") |> to(be_false)
    end

    context "when the value is a string but not JSON" do
      it do: expect has_only_json_values(json, "string") |> to(be_true)
      it do: expect has_only_json_values(json, "another string") |> to(be_false)
    end
  end
end
