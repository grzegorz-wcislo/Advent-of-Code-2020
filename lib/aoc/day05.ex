defmodule Aoc.Day05 do
  @moduledoc false

  def task1(input) do
    input
    |> Enum.map(&seat_id/1)
    |> Enum.max()
  end

  def task2(input) do
    input
    |> Enum.map(&seat_id/1)
    |> Enum.sort()
    |> Enum.chunk_every(2, 1)
    |> Enum.find(&skips_seat?/1)
    |> get_skipped_seat()
  end

  def seat_id(boarding_pass) do
    boarding_pass
    |> String.replace(~r/[BR]/, "1")
    |> String.replace(~r/[FL]/, "0")
    |> Integer.parse(2)
    |> elem(0)
  end

  defp skips_seat?([seat1, seat2]) do
    seat1 + 2 == seat2
  end

  defp get_skipped_seat([seat, _]) do
    seat + 1
  end
end
