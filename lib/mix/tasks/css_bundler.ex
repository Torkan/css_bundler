defmodule Mix.Tasks.CssBundler do
  @moduledoc """
  Bundle multiple css-files into a single one.
  """

  use Mix.Task

  @doc false
  def run(_) do
    extensions =
      Application.get_env(:css_bundler, :extensions, [".css"]) |> CssBundler.pad_extensions()

    CssBundler.bundle_css(extensions)
    {:ok, []}
  end
end
