# Test That JSON!

Assertions and helpers for a better JSON testing experience in Elixir.

Using [ESpec](https://github.com/antonmi/espec)? Check out [test_that_json_espec](https://github.com/facto/test_that_json_espec).

## Assertions

- [X] `is_json_equal`
- [X] `has_json_keys`
- [X] `has_only_json_keys`
- [X] `has_json_values`
- [X] `has_only_json_values`
- [X] `has_json_properties`
- [X] `has_only_json_properties`
- [X] `has_json_path`
- [ ] `has_json_type`
- [ ] `has_json_size`


## Helpers

- [X] `parse_json`
- [X] `parse_json!`
- [X] `to_json`
- [X] `to_json!`
- [X] `prettify_json`
- [X] `prettify_json!`
- [X] `to_prettified_json`
- [X] `to_prettified_json!`
- [X] `load_json`
- [X] `load_json!`


## Additional Functionality

- [ ] Assertions can optionally take a path
- [ ] Assertions can be composed together w/ the pipe |> operator


## Example

```elixir
defmodule MyProject.ExampleTest
  use ExUnit.Case

  import TestThatJson.Assertions
  import TestThatJson.Helpers

  test "verifying JSON key presence" do
    json = load_json("test/support/json/valid.json") # example helper use

    assert has_json_keys(["key1", "key2"])
  end
end
```

Test That JSON! has extensive tests, but they're mostly written as [ESpec](https://github.com/antonmi/espec) specs because I like that style for complex testing. See the `test` directory for some basic happy-path tests, and the `spec` directory for detailed use cases.


## Installation

1. Add `test_that_json` as a test-only dependency in `mix.exs`:

  ```elixir
  def deps do
    [{:test_that_json, "~> 0.5.0", only: :test}]
  end
  ```


## Configuration

### Key Exclusion

By default, to avoid needing to know the values of these ahead of time, the following keys are ignored for all JSON objects: `id`, `inserted_at`, and `updated_at`.

This can be reconfigured as follows:

``` elixir
config :test_that_json,
  excluded_keys: ~w(id inserted_at updated_at some other keys)
```


## Paths

These are simple strings of "/"-separated object keys and array indexes passed to `has_json_path`. For instance, with the following JSON:

``` json
{
  "first_name": "Jon",
  "last_name": "Snow",
  "friends": [
    {
      "first_name": "Know",
      "last_name": "Nothing"
    }
  ]
}
```

We could access the first friend's first name with the path "friends/0/first_name".


## Project Chores

- [X] Tests
- [X] Assertion docs
- [ ] Helper docs


## Related Projects

- [DockYard/json_api_assert](https://github.com/DockYard/json_api_assert)
- [jonasschmidt/ex_json_schema](https://github.com/jonasschmidt/ex_json_schema)


## Thanks

Thanks to the creators and maintainers of the [Ruby json_spec](https://github.com/collectiveidea/json_spec) project for heavy inspiration.


## Contributing

1. Before opening a pull request, please open an issue first.
2. Do the usual fork/add/fix/run tests dance, or whatever tickles your fancy. Tests are highly encouraged.
3. Open a PR.
4. Treat yourself. You deserve it.


## License

See the [LICENSE](LICENSE.md) file for license rights and limitations (MIT).
