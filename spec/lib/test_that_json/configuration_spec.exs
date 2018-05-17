defmodule TestThatJson.ConfigurationSpec do
  use ESpec

  alias TestThatJson.Configuration

  describe "excluded_keys" do
    subject do: Configuration.excluded_keys()

    context "with no keys in the environment" do
      # Assumes no env-configured keys
      it do: should eq(Configuration.default_excluded_keys())
    end

    context "with keys in the environment" do
      let :excluded_keys, do: ~w(some other keys)

      before do
        allow Application |> to(accept(:get_env, fn(_, _, _) -> excluded_keys end))
      end

      it do: should eq(excluded_keys)
    end
  end
end
