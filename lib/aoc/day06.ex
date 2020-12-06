defmodule Aoc.Day06 do
  def task1(input) do
    input
    |> join_groups(&MapSet.union/2)
    |> Enum.map(&MapSet.size/1)
    |> Enum.sum()
  end

  def task2(input) do
    input
    |> join_groups(&MapSet.intersection/2)
    |> Enum.map(&MapSet.size/1)
    |> Enum.sum()
  end

  def join_groups(input, join_fun) do
    chunk_fun = fn element, acc ->
      current_set = MapSet.new(String.graphemes(element))

      cond do
        element == "" and acc == nil -> {:cont, nil}
        element == "" -> {:cont, acc, nil}
        acc == nil -> {:cont, current_set}
        true -> {:cont, join_fun.(acc, current_set)}
      end
    end

    after_fun = fn
      nil -> {:cont, nil}
      acc -> {:cont, acc, nil}
    end

    Enum.chunk_while(input, nil, chunk_fun, after_fun)
  end
end
