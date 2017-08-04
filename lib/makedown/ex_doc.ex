defmodule Makedown.ExDoc do
  @moduledoc """
  A markdown implementation compatible with [ExDoc](https://github.com/elixir-lang/ex_doc)

  To use, follow these steps:
  
  ### Make ExDocs use `Makedown` for markdown rendering
  
  For that, add the following line to your app's `config.exs` file:

      config :ex_doc, :markdown_processor, Makedown.ExDoc

  ### Generate the `Makedown` assets.
  
  Run the following mix task:
  
      mix makedown.ex_doc.assets

  ### Configure ExDocs to use the assets
  
  After generating the assets, edit your project's `:docs` configuration options
  so that it uses the assets we've generated.

  Just add the following lines to the `:docs` config option in your MixFile:

      def project do
        [
          ...
          docs: [
            # This is the location where the mix task will place the assets
            assets: "priv/doc/assets",
            # Extra CSS
            before_closing_head_tag: ~S(<link rel="stylesheet" href="assets/makedown.css" />),
            # Extra Javascript
            before_closing_body_tag: ~S(<script src="assets/makedown.js"></script>)
          ]
        ]
      end
  """

  defp hljs_proof_code(html) do
    html
    |> String.replace("<pre><code>", "<code class=\"makeup-code-block\">")
    |> String.replace("</pre><code>", "<code>")
  end

  @doc false
  def to_html(text, opts) do
    # This function is not meant to be called by the user
    options =
      struct(Earmark.Options,
             gfm: Keyword.get(opts, :gfm, true),
             line: Keyword.get(opts, :line, 1),
             file: Keyword.get(opts, :file),
             breaks: Keyword.get(opts, :breaks, false),
             smartypants: Keyword.get(opts, :smartypants, true))
    text
    |> Makedown.as_html!(options)
    |> hljs_proof_code 
  end
end
