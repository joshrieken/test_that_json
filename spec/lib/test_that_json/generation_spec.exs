defmodule TestThatJson.GenerationSpec do
  use ESpec

  alias TestThatJson.Generation

  describe "generate" do
    subject do: Generation.generate(value)

    let :value, do: "i'm a string"

    it do: should eq({:ok, "\"i'm a string\""})
  end

  describe "generate!" do
    subject do: Generation.generate!(value)

    let :value, do: "i'm a string"

    it do: should eq("\"i'm a string\"")
  end

  describe "generate_prettified" do
    subject do: Generation.generate_prettified(value)

    let :value, do: [1,2,3,4]

    it do: should eq({:ok, "[\n  1,\n  2,\n  3,\n  4\n]"})
  end

  describe "generate_prettified!" do
    subject do: Generation.generate_prettified!(value)

    let :value, do: [1,2,3,4]

    it do: should eq("[\n  1,\n  2,\n  3,\n  4\n]")
  end
end
