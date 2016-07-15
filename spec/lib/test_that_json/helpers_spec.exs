defmodule TestThatJson.HelpersSpec do
  use ESpec

  alias TestThatJson.Helpers

  let :json, do: "[1,2,3,4]"

  describe "parse_json" do
    before do
      allow TestThatJson.Parsing |> to(accept(:parse, fn _ -> nil end))
      Helpers.parse_json(json)
    end

    it "calls the correct function" do
      expect TestThatJson.Parsing |> to(accepted(:parse, [json]))
    end
  end

  describe "parse_json!" do
    before do
      allow TestThatJson.Parsing |> to(accept(:parse!, fn _ -> nil end))
      Helpers.parse_json!(json)
    end

    it "calls the correct function" do
      expect TestThatJson.Parsing |> to(accepted(:parse!, [json]))
    end
  end

  describe "to_json" do
    before do
      allow TestThatJson.Generation |> to(accept(:generate, fn _ -> nil end))
      Helpers.to_json(json)
    end

    it "calls the correct function" do
      expect TestThatJson.Generation |> to(accepted(:generate, [json]))
    end
  end

  describe "to_json!" do
    before do
      allow TestThatJson.Generation |> to(accept(:generate!, fn _ -> nil end))
      Helpers.to_json!(json)
    end

    it "calls the correct function" do
      expect TestThatJson.Generation |> to(accepted(:generate!, [json]))
    end
  end

  describe "prettify_json" do
    before do
      allow TestThatJson.Normalization |> to(accept(:prettify, fn _ -> nil end))
      Helpers.prettify_json(json)
    end

    it "calls the correct function" do
      expect TestThatJson.Normalization |> to(accepted(:prettify, [json]))
    end
  end

  describe "prettify_json!" do
    before do
      allow TestThatJson.Normalization |> to(accept(:prettify!, fn _ -> nil end))
      Helpers.prettify_json!(json)
    end

    it "calls the correct function" do
      expect TestThatJson.Normalization |> to(accepted(:prettify!, [json]))
    end
  end

  describe "to_prettified_json" do
    before do
      allow TestThatJson.Generation |> to(accept(:generate_prettified, fn _ -> nil end))
      Helpers.to_prettified_json(json)
    end

    it "calls the correct function" do
      expect TestThatJson.Generation |> to(accepted(:generate_prettified, [json]))
    end
  end

  describe "to_prettified_json!" do
    before do
      allow TestThatJson.Generation |> to(accept(:generate_prettified, fn _ -> nil end))
      Helpers.to_prettified_json(json)
    end

    it "calls the correct function" do
      expect TestThatJson.Generation |> to(accepted(:generate_prettified, [json]))
    end
  end

  describe "load_json" do
    before do
      allow TestThatJson.Loading |> to(accept(:load, fn _ -> nil end))
      Helpers.load_json(json)
    end

    it "calls the correct function" do
      expect TestThatJson.Loading |> to(accepted(:load, [json]))
    end
  end

  describe "load_json!" do
    before do
      allow TestThatJson.Loading |> to(accept(:load!, fn _ -> nil end))
      Helpers.load_json!(json)
    end

    it "calls the correct function" do
      expect TestThatJson.Loading |> to(accepted(:load!, [json]))
    end
  end
end
