# Makedown

Makedown is a markdown implementation compatible with [ExDoc](https://github.com/elixir-lang/ex_doc)
that uses [Makeup](https://github.com/elixir-lang/ex_doc) to highlight code blocks.
It is just `Earmark` with a custom code rendering function. 

Besides the main `Markdown` module, the application also contains an `ExDoc`-compatible markdown implementation so you can use it on your project's docs.

## Installation

The package [available in Hex](https://hex.pm/docs/publish).
It can be installed by adding `makedown` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:makedown, "~> 0.1.0"}
  ]
end
```

Documentation can be found on [HexDocs](https://hexdocs.pm).

## User Guide

The API is compatible with [Earmark](https://github.com/pragdave/earmark). The user-facing functions are:

```elixir
Makedown.as_html!(text, options \\ %{})
Makedown.as_html(text, options \\ %{})
```

where options can be a dict or a `%Earmark.Options{}` struct.

## Integration with `ExDoc`

`ExDoc` can be configured to use alternative Markdown processors.
Even though `Makedown` itself is *not* compatible with `ExDoc`,
it ships with the `Makedown.ExDoc` module which is compatible.

To use `Makedown` with `ExDocs`, follow these steps

#### 1. Make `ExDoc` use `Makedown` for markdown rendering

For that, add the following line to your app's `config.exs` file:

    config :ex_doc, :markdown_processor, Makedown.ExDoc

Note that it must de `Makedown.ExDoc` and not `Makedown`.
`Makedown` itself is not compatible with `ExDoc`.

#### 2. Generate the `Makedown` assets.

`Makedown` needs some special CSS stylesheets to render render the code properly,
and a little Javascript file (optional) for full functionality.

Those files must be generated and included in the `ExDoc` documentation.

To generate the files, run the following mix task:

    mix makedown.ex_doc.assets

The assets will be placed at `priv/doc/assets`.
This directory will be created if it doesn't already exist.
You can move those files to an alternative location, as long as you edit the `ExDoc` configuration options accordingly.

#### 3. Configure `ExDoc` to use the assets

After generating the assets, edit your project's `:docs` configuration options
so that it uses the assets we've generated.

Just add the following lines to the `:docs` config option in your MixFile:

```elixir
  def project do
    [
      ...
      docs: [
        # This is the location where the mix task has placed the assets
        # You can move them to another location, ad long as you change
        # this option accordingly.
        assets: "priv/doc/assets",
        # Extra CSS
        before_closing_head_tag: ~S(<link rel="stylesheet" href="assets/makedown.css"/>),
        # Extra Javascript
        before_closing_body_tag: ~S(<script src="assets/makedown.js"></script>)
      ]
    ]
  end
```

### ExDoc themes

`Makedown` includes a CSS theme that plays relatively well with the `ExDocs` theme.
The "day mode" theme is a slightly changed version of Pygments' *Tango* style.
The "night mode" theme is a slightly changed version of Pygments' *ParaisoDark* theme.

I'm not 100% happy with the themes (especially the one for the night mode), and welcome contributions.