defmodule Aoc.Day01 do
  def task1 do
    {:ok, {e1, e2}} = sum2_to(2020, read_elements())
    e1 * e2
  end

  def task2 do
    {:ok, {e1, e2, e3}} = sum3_to(2020, read_elements())
    e1 * e2 * e3
  end

  def read_elements() do
    File.stream!("day01_input")
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list()
  end

  def k_combinations(elements, k) when k <= 0 or length(elements) < k do
    []
  end

  def k_combinations(elements, k) when k == 1 do
    Enum.map(elements, &[&1])
  end

  def k_combinations(elements, k) do
    elements_with_index = Stream.with_index(elements)

    elements_with_index
    |> Stream.flat_map(fn {element1, index1} ->
      available_elements =
        elements_with_index
        |> Enum.filter(fn {_, index2} -> index2 > index1 end)
        |> Enum.map(&elem(&1, 0))

      Enum.map(k_combinations(available_elements, k - 1), &[element1 | &1])
    end)
    |> Enum.to_list()
  end

  def sum2_to(sum, elements) do
    case Enum.find(k_combinations(elements, 2), fn [e1, e2] -> e1 + e2 == sum end) do
      nil -> :error
      result -> {:ok, result}
    end
  end

  def sum3_to(sum, elements) do
    case Enum.find(k_combinations(elements, 3), fn [e1, e2, e3] -> e1 + e2 + e3 == sum end) do
      nil -> :error
      result -> {:ok, result}
    end
  end
end
