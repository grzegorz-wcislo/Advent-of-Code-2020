defmodule Aoc.Day11 do
  def task1(input) do
    input
    |> Enum.map(&String.graphemes/1)
    |> find_stable_configuration(&next_iteration/1)
    |> Enum.map(fn row -> Enum.count(row, fn e -> e == "#" end) end)
    |> Enum.sum()
  end

  def task2(input) do
    input
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&Enum.with_index/1)
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, i} ->
      Enum.map(row, fn {elem, j} ->
        {{i, j}, elem}
      end)
    end)
    |> Enum.into(%{})
    |> find_stable_configuration(&next_iteration2/1)
    |> Map.values()
    |> Enum.count(fn e -> e == "#" end)
  end

  defp find_stable_configuration(seats, next_iteration_fun) do
    next_seats = next_iteration_fun.(seats)

    if next_seats == seats do
      next_seats
    else
      find_stable_configuration(next_seats, next_iteration_fun)
    end
  end

  def next_iteration(seats) do
    seats
    |> pad_seats()
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&Enum.zip/1)
    |> Enum.map(&Enum.chunk_every(&1, 3, 1, :discard))
    |> enum_map_2d(&extract_neighbourhood/1)
    |> enum_map_2d(&next_element/1)
  end

  defp extract_neighbourhood([{a, b, c}, {d, e, f}, {g, h, i}]) do
    {e, [a, b, c, d, f, g, h, i]}
  end

  defp enum_map_2d(enum, fun) do
    Enum.map(enum, &Enum.map(&1, fun))
  end

  defp next_element({".", _}), do: "."

  defp next_element({"L", neighbours}) do
    if Enum.any?(neighbours, fn neighbour -> neighbour == "#" end) do
      "L"
    else
      "#"
    end
  end

  defp next_element({"#", neighbours}) do
    if Enum.count(neighbours, fn neighbour -> neighbour == "#" end) >= 4 do
      "L"
    else
      "#"
    end
  end

  def pad_seats(seats) do
    rows = Enum.map(seats, fn row -> ["L"] ++ row ++ ["L"] end)
    padding_row = rows |> hd |> Enum.map(fn _ -> "L" end)

    [padding_row] ++ rows ++ [padding_row]
  end

  defp next_iteration2(seats) do
    for {{i, j}, value} <- seats, into: %{} do
      {{i, j}, next_element2({value, find_neighbours({i, j}, seats)})}
    end
  end

  defp find_neighbours({i, j}, seats) do
    [{1, 0}, {1, 1}, {0, 1}, {-1, 1}, {-1, 0}, {-1, -1}, {0, -1}, {1, -1}]
    |> Enum.map(fn dir -> find_neighbour({i, j}, seats, dir) end)
  end

  defp find_neighbour({i, j}, seats, {di, dj}) do
    case Map.get(seats, {i + di, j + dj}, "L") do
      "." -> find_neighbour({i + di, j + dj}, seats, {di, dj})
      neighbour -> neighbour
    end
  end

  defp next_element2({".", _}), do: "."

  defp next_element2({"L", neighbours}) do
    if Enum.any?(neighbours, fn neighbour -> neighbour == "#" end) do
      "L"
    else
      "#"
    end
  end

  defp next_element2({"#", neighbours}) do
    if Enum.count(neighbours, fn neighbour -> neighbour == "#" end) >= 5 do
      "L"
    else
      "#"
    end
  end
end
