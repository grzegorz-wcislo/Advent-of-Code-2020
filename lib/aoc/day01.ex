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

  def sum2_to(sum, elements) do
    elements_with_index = Enum.with_index(elements)

    element_pairs =
      Enum.flat_map(elements_with_index, fn {element, index} ->
        Enum.map(
          Enum.filter(elements_with_index, fn {_, i} ->
            i > index
          end),
          fn {element2, _index2} ->
            {element, element2}
          end
        )
      end)

    case Enum.find(element_pairs, fn {e1, e2} -> e1 + e2 == sum end) do
      nil -> :error
      result -> {:ok, result}
    end
  end

  def sum3_to(sum, elements) do
    elements_with_index = Enum.with_index(elements)

    element_triplets =
      Enum.flat_map(
        elements_with_index,
        fn {element1, index1} ->
          Enum.flat_map(
            Enum.filter(
              elements_with_index,
              fn {_, index2} ->
                index2 > index1
              end
            ),
            fn {element2, index2} ->
              Enum.map(
                Enum.filter(
                  elements_with_index,
                  fn {_, index3} ->
                    index3 > index2
                  end
                ),
                fn {element3, _index3} ->
                  {element1, element2, element3}
                end
              )
            end
          )
        end
      )

    case Enum.find(element_triplets, fn {e1, e2, e3} -> e1 + e2 + e3 == sum end) do
      nil -> :error
      result -> {:ok, result}
    end
  end
end
