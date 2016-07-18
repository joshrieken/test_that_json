# Test That JSON!

Assertions and helpers for a better JSON testing experience in Elixir.


## Assertions

- [x] `is_json_equal`
- [x] `has_json_keys`
- [x] `has_only_json_keys`
- [x] `has_json_values`
- [x] `has_only_json_values`
- [x] `has_json_properties`
- [x] `has_only_json_properties`
- [x] `has_json_path`
- [ ] `has_json_type`
- [ ] `has_json_size`


## Helpers

- [x] `parse_json`
- [x] `parse_json!`
- [x] `to_json`
- [x] `to_json!`
- [x] `prettify_json`
- [x] `prettify_json!`
- [x] `to_prettified_json`
- [x] `to_prettified_json!`
- [x] `load_json`
- [x] `load_json!`


## Additional Functionality

- [ ] Assertions can optionally take a path


## ESpec

See [test_that_json_espec](https://github.com/facto/test_that_json_espec) for ESpec matchers.


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


## Thanks

Thanks to the creators and maintainers of the [Ruby json_spec](https://github.com/collectiveidea/json_spec) project for heavy inspiration.


## Installation

1. Add `test_that_json` as a test-only dependency in `mix.exs`:

  ```elixir
  def deps do
    [{:test_that_json, "~> 0.5.0", only: :test}]
  end
  ```


## Contributing

1. Before opening a pull request, please open an issue first.
2. Do the usual fork/add/fix/run tests dance, or whatever tickles your fancy. Tests are highly encouraged.
3. Open a PR.
4. Treat yourself. You deserve it.


## License

See the [LICENSE](LICENSE.md) file for license rights and limitations (MIT).
