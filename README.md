# Test That JSON!

JSON helpers and matchers for ExUnit and [ESpec](https://github.com/antonmi/espec).

## ExUnit

## ESpec

Matchers:

- [x] `be_json_eql`
- [x] `have_json_keys`
- [x] `have_only_json_keys`
- [x] `have_json_values`
- [x] `have_only_json_values`
- [x] `have_json_properties`
- [x] `have_only_json_properties`
- [x] `have_json_path`
- [ ] `have_json_type`
- [ ] `have_json_size`

Helpers:

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

## Paths

These are simple strings of "/" separated hash keys and array indexes. For instance, with the following JSON:

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

1. Add `test_that_json` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:test_that_json, "~> 0.1.0", only: :test}]
  end
  ```

### Using ESpec

Make sure espec is in your `mix.exs` as well.

## License

See the [LICENSE](LICENSE.md) file for license rights and limitations (MIT).
