defmodule Aoc.Day06 do
  def task1(input) do
    input
    |> join_groups
    |> Enum.map(&MapSet.size/1)
    |> Enum.sum()
  end

  def join_groups(input) do
    chunk_fun = fn element, acc ->
      if element == "" do
        {:cont, acc, MapSet.new()}
      else
        letters = String.graphemes(element)
        {:cont, MapSet.union(acc, MapSet.new(letters))}
      end
    end

    after_fun = fn acc ->
      if MapSet.size(acc) == 0 do
        {:cont, []}
      else
        {:cont, acc, []}
      end
    end

    Enum.chunk_while(input, MapSet.new(), chunk_fun, after_fun)
  end
end
