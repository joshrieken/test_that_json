defmodule TestThatJson.LoadingSpec do
  use ESpec

  alias TestThatJson.Loading

  let :path, do: "spec/support/json/valid.json"

  describe "load" do
    subject do: Loading.load(path)

    it do: should eq({:ok, "[1,2,3,4]"})
  end

  describe "load!" do
    subject do: Loading.load!(path)

    it do: should eq("[1,2,3,4]")
  end
end
