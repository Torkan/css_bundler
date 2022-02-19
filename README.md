# CssBundler

**Scans your project folder for css-files, and bundles them into a single output file.**

## Rationale

Created in order to be able to write css spread across multiple files when working on a
Phoenix-project that uses Tailwind[https://github.com/phoenixframework/tailwind].

It basically listens for updates to any css-files specified directories (or sub-directories),
as well as the entrypoint css-file.

When an update is detected, it simply takes the contents of each found css-file and dumps
it into the specified output-file.

## Installation

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
  output_file: "assets/css/app.css",
  dirs: ["assets/css/styles", "lib/myapp_web"],
  extensions: [".css", ".scss"] (default: [".css"]),
  silent: true (default false)
```

The entrypoint-file will be added to the beginning of the output-file, in case you need any
top-level declearations (like when using Tailwind).

Example `entrypoint.css`:

```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

If you have some styles that only apply to a single LiveView-component, for example
`lib/myapp_web/live/my_component.ex`, you can colocate its styles in
`lib/myapp_web/live/my_component.css`, just make sure you add the needed directories in
`config.exs`.

Example `lib/myapp_web/live/my_component.ex`:

```elixir
def render(assigns) do
  ~H"""
    <div class="mb-4">
      <label>
        <p class="mb-2 text-xs">Search</p>
        <form action="#" phx-change={
          JS.push("search", loading: "#search-container")
        }>
          <input
            name="search"
            type="text"
            autocomplete="off"
            class="text-input"
            phx-debounce="300"
            value={@search}>
        </form>
      </label>
    </div>
    <div id="search-container">
      <div id="search-spinner">
        Searching...
      </div>
      <div id="search-results">
      </div>
    </div>
  """
end
```

Example `lib/myapp_web/live/my_component.css`:

```css
#search-container #search-spinner {
  display: none;
}

#search-container #search-results {
  display: block;
}

#search-container.phx-change-loading #search-spinner {
  display: block;
}

#search-container.phx-change-loading #search-results {
  display: none;
}
```
