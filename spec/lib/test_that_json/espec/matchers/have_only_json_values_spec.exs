defmodule TestThatJson.ESpec.Matchers.HaveOnlyJsonValuesSpec do
  use ESpec

  import TestThatJson.ESpec.Matchers, only: [have_only_json_values: 1]

  subject do: json

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

      it do: should have_only_json_values(%{"nested" => "object y'all"})
      it do: should_not have_only_json_values(%{"missing" => "object"})
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
        it do: should have_only_json_values(["object", "key with value", %{"nested" => "object y'all"}])
      end

      context "when more than the provided values are present" do
        it do: should_not have_only_json_values(["object"])
      end

      context "when fewer than the provided values are present" do
        it do: should_not have_only_json_values(["object", "key with value", "yet_another", %{"nested" => "object y'all"}])
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

        it do: should have_only_json_values("object")
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

        it do: should_not have_only_json_values("property")
        it do: should_not have_only_json_values("another property")
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

      it do: should have_only_json_values([
        %{"some" => "object", "another" => "key with value"},
        %{"another" => "object"},
        ["a list with a string"],
        "some string",
      ])

      it do: should_not have_only_json_values([
        %{"another" => "object"},
        %{"some" => "object", "another" => "key with value"},
        ["a list with a string"],
        "some string",
      ])

      it do: should_not have_only_json_values([
        %{"another" => "object"},
        ["a list with a string"],
        "some string",
      ])

      it do: should_not have_only_json_values([
        %{"some" => "object", "another" => "key with value"},
        %{"another" => "object"},
        ["a list with a string"],
        "some string",
        "another string",
      ])
    end

    context "when the value is a map" do
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

      it do: should have_only_json_values(%{"some" => "object", "another" => "key with value"})
      it do: should_not have_only_json_values(%{"some_other" => "object"})
    end

    context "when the value is a string" do
      context "when the string is valid JSON" do
        it do: should have_only_json_values("[\"a list with a string\"]")
        it do: should_not have_only_json_values("\"a list with a string\"")
      end

      context "when the string is not JSON" do
        it do: should have_only_json_values("some string")
        it do: should_not have_only_json_values("some other string")
      end
    end
  end
end
