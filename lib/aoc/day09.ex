defmodule Aoc.Day09 do
  def task1(input) do
    input
    |> Stream.map(&String.to_integer/1)
    |> find_first_unsummable(25)
  end

  def task2(input) do
    input
    |> Stream.map(&String.to_integer/1)
    |> find_encryption_weakness(25)
  end

  def find_first_unsummable(numbers, preamble) do
    numbers
    |> Stream.chunk_every(preamble + 1, 1, :discard)
    |> Enum.find_value(fn elems ->
      [sum | numbers] = Enum.reverse(elems)

      if sum_to?(numbers, sum) do
        false
      else
        sum
      end
    end)
  end

  def find_encryption_weakness(numbers, preamble) do
    sum = find_first_unsummable(numbers, preamble)
    set = find_contigous_sum(numbers, sum)
    Enum.min(set) + Enum.max(set)
  end

  def sum_to?(numbers, sum) do
    Enum.sort(numbers)
    |> do_sum_to?(sum, 0, length(numbers) - 1)
  end

  defp do_sum_to?(_, _, i, j) when i >= j, do: false

  defp do_sum_to?(numbers, sum, i, j) do
    current_sum = Enum.at(numbers, i) + Enum.at(numbers, j)

    cond do
      current_sum == sum -> true
      current_sum > sum -> do_sum_to?(numbers, sum, i, j - 1)
      current_sum < sum -> do_sum_to?(numbers, sum, i + 1, j)
    end
  end

  def find_contigous_sum(numbers, sum) do
    do_find_contigous_sum(numbers, sum, 0, 0)
  end

  defp do_find_contigous_sum(numbers, sum, i, j) do
    current_sum = numbers |> Enum.slice(i..j) |> Enum.sum()

    cond do
      current_sum == sum -> Enum.slice(numbers, i..j)
      current_sum > sum -> do_find_contigous_sum(numbers, sum, i + 1, j)
      current_sum < sum -> do_find_contigous_sum(numbers, sum, i, j + 1)
    end
  end
end
