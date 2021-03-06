defmodule Aoc.Runner do
  @moduledoc """
  A runner for Advent of Code tasks.
  """

  def run(day, task) do
    with {:ok, module} <- get_module(day),
         {:ok, task_fun} <- get_task_fun(module, day, task) do
      input_file = get_input_file(day)

      try do
        input = Aoc.Input.read_lines(input_file)
        {:ok, apply(module, task_fun, [input])}
      rescue
        _ in File.Error -> {:error, "Could not find input file '#{input_file}'"}
        e -> {:error, {e, __STACKTRACE__}}
      end
    end
  end

  def get_module(day) do
    try do
      module = String.to_existing_atom("Elixir.Aoc.Day#{to_2digit_string(day)}")
      apply(module, :__info__, [:functions])
      {:ok, module}
    rescue
      _ -> {:error, "Could not find day #{day} task runner"}
    end
  end

  def get_task_fun(module, day, task) do
    error = {:error, "Could not find task #{task} for day #{day}"}

    try do
      task_fun = String.to_atom("task#{task}")

      if function_exported?(module, task_fun, 1) do
        {:ok, task_fun}
      else
        error
      end
    rescue
      _ -> error
    end
  end

  def get_input_file(day) do
    "inputs/day#{to_2digit_string(day)}_input"
  end

  def to_2digit_string(num) do
    String.pad_leading(num, 2, "0")
  end
end
