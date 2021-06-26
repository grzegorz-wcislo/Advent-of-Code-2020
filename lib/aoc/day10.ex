defmodule Aoc.Day10 do
  @moduledoc false

  def task1(input) do
    numbers = Enum.map(input, &String.to_integer/1)

    {ones, threes} =
      numbers
      |> Enum.concat([0, Enum.max(numbers) + 3])
      |> Enum.sort()
      |> calculate_differences()
      |> count_ones_threes()

    ones * threes
  end

  def task2(input) do
    numbers = Enum.map(input, &String.to_integer/1)

    numbers
    |> Enum.concat([0, Enum.max(numbers) + 3])
    |> Enum.sort()
    |> calculate_differences()
    |> Enum.chunk_by(&Function.identity/1)
    |> Enum.filter(&(hd(&1) == 1))
    |> Enum.map(&Enum.count/1)
    |> Enum.map(&(&1 + 1))
    |> Enum.map(&fib3/1)
    |> Enum.reduce(&*/2)
  end

  def calculate_differences(numbers) do
    numbers
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [a, b] -> b - a end)
  end

  def count_ones_threes(numbers) do
    numbers
    |> Enum.reduce({0, 0}, fn
      1, {ones, threes} -> {ones + 1, threes}
      3, {ones, threes} -> {ones, threes + 1}
      _, acc -> acc
    end)
  end

  def fib3(i) do
    0..i
    |> Stream.drop(1)
    |> Enum.reduce({0, 1, 1}, fn _, {a, b, c} ->
      {b, c, a + b + c}
    end)
    |> elem(0)
  end
end
