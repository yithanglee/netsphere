defmodule Mix.Tasks.EsbuildScript do
  use Mix.Task

  def run(_) do
    # cmd = "node esbuild.config.js" # Replace with the actual path to your esbuild config file if needed
    # System.cmd("bash", ["-c", cmd])

    {output, status} = System.cmd("node", ["esbuild.config.js"])
    IO.puts("Command output: #{output}")
    IO.puts("Command status: #{status}")
  end
end
