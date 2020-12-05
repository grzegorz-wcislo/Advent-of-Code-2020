defmodule Aoc.Day03 do
  def task1(input) do
    Enum.reduce(input, {0, 0}, fn current, {current_x, trees_hit} ->
      current_length = String.length(current)
      tree_hit = String.slice(current, rem(current_x, current_length), 1) == "#"
      {current_x + 3, trees_hit + if(tree_hit, do: 1, else: 0)}
    end)
    |> elem(1)
  end
end
