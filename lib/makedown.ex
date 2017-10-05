defmodule Makedown do
  @moduledoc """
  Earmark markdown using [Makeup]() for syntax highlighting.

  Underneath it's just [Earmark](https://github.com/pragdave/earmark)
  """

  alias Earmark.Block

  defp pick_language(nil), do: "elixir"
  defp pick_language("elixir"), do: "elixir"
  defp pick_language(other), do: other 


  defp code_renderer(%Block.Code{lines: lines, language: language}) do
    lang = pick_language(language)
    if lang == "elixir" do
      lines
      |> Enum.join("\n")
      |> Makeup.highlight_inner_html(lexer: lang)
    else
      lines
      |> Enum.join("\n")
      |> HtmlEntities.encode
    end
  end

  @doc """
  Render markdown into HTML. See [here](https://github.com/pragdave/earmark#api).
  """
  def as_html!(source, options) do
    render_code = fn block ->
      code_renderer(block)
    end
    Earmark.as_html!(source, options |> Map.put(:render_code, render_code))
  end

  @doc """
  Render markdown into HTML. See [here](https://github.com/pragdave/earmark#api).
  """
  def as_html(source, options) do
    render_code = fn block ->
      code_renderer(block)
    end
    Earmark.as_html(source, options |> Map.put(:render_code, render_code))
  end
end
