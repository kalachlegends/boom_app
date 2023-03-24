defmodule Mix.Tasks.Ms.Gen.Collection do
  @moduledoc "GENERATE POSTMAN COLECTIONS"
  @shortdoc "GENERATE POSTMAN COLECTIONS"
  @requirements ["app.start"]
  use Mix.Task

  @impl Mix.Task
  def run(args) do
    case Manuscript.Postman.generate() do
      {:ok, file} ->
        Mix.shell().info("""

        --->>>> MANUSCRIPT GENERATE POSTMAN COLECTIONS
        FILE_PATH -> #{file}

        """)

      {:error, reason} ->
        Mix.shell().info("""
        --->>>> MANUSCRIPT ERROR
        ERROR -> #{reason}
        """)
    end
  end
end
