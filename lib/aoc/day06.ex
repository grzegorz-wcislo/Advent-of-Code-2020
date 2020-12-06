defmodule Aoc.Day06 do
  def task1(input) do
    task_with_join_fun(input, &MapSet.union/2)
  end

  def task2(input) do
    task_with_join_fun(input, &MapSet.intersection/2)
  end

  def task_with_join_fun(input, join_fun) do
    input
    |> parse_groups()
    |> Enum.map(fn group -> Enum.map(group, &String.graphemes/1) end)
    |> Enum.map(fn group -> Enum.map(group, &MapSet.new/1) end)
    |> Enum.map(fn group -> Enum.reduce(group, join_fun) end)
    |> Enum.map(&MapSet.size/1)
    |> Enum.sum()
  end

  def parse_groups(input) do
    chunk_fun = fn element, acc ->
      case element do
        "" -> {:cont, Enum.reverse(acc), []}
        _ -> {:cont, [element | acc]}
      end
    end

    after_fun = fn
      [] -> {:cont, []}
      acc -> {:cont, Enum.reverse(acc), []}
    end

    Enum.chunk_while(input, [], chunk_fun, after_fun)
  end
end
