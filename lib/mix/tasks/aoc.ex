defmodule Mix.Tasks.Aoc do
  use Mix.Task

  def run(args) do
    if length(args) != 2 do
      IO.puts("Please pass day and task")
    else
      [day, task] = args
      IO.puts("Executing task #{task} for day #{day}")

      case Aoc.Runner.run(day, task) do
        {:ok, result} ->
          IO.puts("Result:\n#{result}")

        {:error, {error, stacktrace}} ->
          IO.puts("Got an error:")
          IO.puts(Exception.format(:error, error, stacktrace))

        {:error, error} ->
          IO.puts(error)
      end
    end
  end
end
