defmodule Aoc.Day15 do
  @moduledoc false

  def task1(input) do
    task_nth(input, 2020)
  end

  def task2(input) do
    task_nth(input, 30_000_000)
  end

  def task_nth([input], n) do
    input
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> get_nth_number(n)
  end

  def get_nth_number(starting_numbers, n) do
    do_get_nth_number(starting_numbers, 0, %{}, 1, n)
  end

  defp do_get_nth_number([head | _], _, _, k, n) when n == k, do: head

  defp do_get_nth_number(_, prev, hist, k, n) when n == k do
    get_next(hist, prev)
  end

  defp do_get_nth_number([head | tail], _, hist, k, n) do
    do_get_nth_number(tail, head, Map.update(hist, head, [k], &[k | &1]), k + 1, n)
  end

  defp do_get_nth_number(_, prev, hist, k, n) do
    next = get_next(hist, prev)

    do_get_nth_number([], next, Map.update(hist, next, [k], &[k | &1]), k + 1, n)
  end

  defp get_next(hist, prev) do
    case Map.get(hist, prev) do
      [last, butlast | _] -> last - butlast
      _ -> 0
    end
  end
end
