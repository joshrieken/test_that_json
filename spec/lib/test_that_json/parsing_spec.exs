defmodule TestThatJson.ParsingSpec do
  use ESpec

  alias TestThatJson.Parsing

  describe "parse!" do
    let :json, do: "[1,2,3]"

    before do
      allow JSX |> to(accept(:decode!, fn(_) -> nil end))
      Parsing.parse!(json)
    end

    it "calls the correct command" do
      expect JSX |> to(accepted(:decode!, [json]))
    end
  end

  describe "parse" do
    let :json, do: "[1,2,3]"

    before do
      allow JSX |> to(accept(:decode, fn(_) -> nil end))
      Parsing.parse(json)
    end

    it "calls the correct command" do
      expect JSX |> to(accepted(:decode, [json]))
    end
  end
end
