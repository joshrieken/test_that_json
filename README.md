# ESpec JSON

JSON matchers and helpers for [ESpec](https://github.com/antonmi/espec).

Matchers:

- [x] `be_json_eql`
- [ ] `include_json`
- [ ] `have_json_path`
- [ ] `have_json_type`
- [ ] `have_json_size`

Helpers:

- [ ] `parse_json`
- [ ] `normalize_json`
- [ ] `generate_normalized_json`
- [ ] `load_json`

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

## Inspiration

Thanks to the creators and maintainers of the [Ruby json_spec](https://github.com/collectiveidea/json_spec) project for heavy inspiration.

## Installation

1. Add `espec_json` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:espec_json, "~> 0.1.0", only: :test}]
  end
  ```
