defmodule Aoc.Runner do
  def run(day, task) do
    case get_module(day) do
      {:ok, module} ->
        try do
          case get_task_fun(task) do
            {:ok, task_fun} ->
              input_file = get_input_file(day)

              try do
                input = Aoc.Input.read_lines(input_file)
                apply(module, task_fun, [input])
              rescue
                _ in File.Error -> IO.puts("Could not find input file '#{input_file}'")
              end

            _ ->
              raise UndefinedFunctionError
          end
        rescue
          _ in UndefinedFunctionError ->
            IO.puts("Could not find task #{task} for day #{day}")
        end

      _ ->
        IO.puts("Could not find day #{day} task runner")
    end
  end

  def get_module(day) do
    try do
      {:ok, String.to_existing_atom("Elixir.Aoc.Day0#{day}")}
    rescue
      _ -> :error
    end
  end

  def get_task_fun(task) do
    try do
      {:ok, String.to_existing_atom("task#{task}")}
    rescue
      _ -> :error
    end
  end

  def get_input_file(day) do
    "day0#{day}_input"
  end
end
