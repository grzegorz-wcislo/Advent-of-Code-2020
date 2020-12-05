defmodule Aoc.Day01 do
  def task1(input) do
    elements = Enum.map(input, &String.to_integer/1)
    {:ok, [e1, e2]} = sum2_to(2020, elements)
    e1 * e2
  end

  def task2(input) do
    elements = Enum.map(input, &String.to_integer/1)
    {:ok, [e1, e2, e3]} = sum3_to(2020, elements)
    e1 * e2 * e3
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

  def to_result(nil), do: :error
  def to_result(result), do: {:ok, result}

  def sum_n_to(sum, elements, n) do
    k_combinations(elements, n)
    |> Enum.find(&(length(&1) == n and Enum.sum(&1) == sum))
    |> to_result()
  end

  def sum2_to(sum, elements) do
    sum_n_to(sum, elements, 2)
  end

  def sum3_to(sum, elements) do
    sum_n_to(sum, elements, 3)
  end
end
