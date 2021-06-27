defmodule Aoc.Day17 do
  @moduledoc false

  def task1(input) do
    parse_input(input)
    |> step()
    |> step()
    |> step()
    |> step()
    |> step()
    |> step()
    |> MapSet.size()
  end

  def parse_input(input) do
    input
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.map(&Enum.with_index/1)
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} ->
      Enum.map(row, fn {col, x} ->
        {col, x, y}
      end)
    end)
    |> Enum.flat_map(fn {active, x, y} ->
      case active do
        "#" -> [{x, y, 0}]
        _ -> []
      end
    end)
    |> MapSet.new()
  end

  def step(active) do
    active
    |> Enum.flat_map(&neighbours/1)
    |> Enum.frequencies()
    |> Map.to_list()
    |> Enum.filter(fn {cube, count} ->
      case count do
        3 -> true
        2 -> MapSet.member?(active, cube)
        _ -> false
      end
    end)
    |> Enum.map(&elem(&1, 0))
    |> MapSet.new()
  end

  defp neighbours({x, y, z}) do
    for dx <- -1..1,
        dy <- -1..1,
        dz <- -1..1,
        {dx, dy, dz} != {0, 0, 0} do
      {x + dx, y + dy, z + dz}
    end
  end
end
