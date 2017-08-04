defmodule Mix.Tasks.Makedown.ExDoc.Assets do
  @moduledoc """
  This task will clean most of the files installed by the `mix coh.install` task.

  """
  use Mix.Task

  @spec run([String.t] | []) :: any
  def run(_) do
    dst_dir = "priv/doc/assets/"
    src_dir = Application.app_dir(:makedown, "priv/ex_doc/assets")
    File.mkdir_p!(dst_dir)
    File.cp_r!(src_dir, dst_dir)
    IO.write "Assets written to '#{dst_dir}'."
  end

end