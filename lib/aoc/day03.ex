defmodule Aoc.Day03 do
  def task1(input) do
    count_trees(input, 3, 1)
  end

  def task2(input) do
    count_trees(input, 1, 1) *
      count_trees(input, 3, 1) *
      count_trees(input, 5, 1) *
      count_trees(input, 7, 1) *
      count_trees(input, 1, 2)
  end

  def count_trees(input, x, y) do
    input
    |> Enum.take_every(y)
    |> Enum.reduce({0, 0}, fn current, {current_x, trees_hit} ->
      current_length = String.length(current)
      tree_hit = String.slice(current, rem(current_x, current_length), 1) == "#"
      {current_x + x, trees_hit + if(tree_hit, do: 1, else: 0)}
    end)
    |> elem(1)
  end
end
