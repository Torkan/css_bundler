# CssBundler

**Scans your project folder for css-files, and bundles them into a single output file.**

## Rationale

Created in order to be able to write css spread across multiple files when working on a
Phoenix-project that uses Tailwind[https://github.com/phoenixframework/tailwind].

It basically listens for updates to any css-files in the specified directions, as well as the
entrypoint css-file.

When an update is detected, it simply takes the contents of each found css-file and dumps
it into the specified output-file.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `css_bundler` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:css_bundler, "~> 0.1.0", runtime: Mix.env() == :dev}
  ]
end
```

In `config.exs`:

```elixir
config :css_bundler,
  entrypoint_file: "assets/css/entrypoint.css",
  output_file: "assets/css/app.css,
  dirs: ["assets/css/styles", "lib/myapp_web],
  extensions: [".css", ".scss"] (default: [".css"]),
  silent: true (default false)
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/css_bundler](https://hexdocs.pm/css_bundler).

```

```
