defmodule TestThatJson.ESpec.HaveJsonPropertiesSpec do
  use ESpec

  subject do: json

  context "when the subject is a JSON object" do
    let :json, do: "{\"some\": \"object\", \"another\": \"object with value\"}"
  end
end
