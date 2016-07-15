defmodule TestThatJson.NormalizationSpec do
  use ESpec

  alias TestThatJson.Normalization

  let :json, do: "[1,2,3,4]"

  describe "prettify" do
    subject do: Normalization.prettify(json)

    it do: should eq({:ok, "[\n  1,\n  2,\n  3,\n  4\n]"})
  end

  describe "prettify!" do
    subject do: Normalization.prettify!(json)

    it do: should eq("[\n  1,\n  2,\n  3,\n  4\n]")
  end
end
