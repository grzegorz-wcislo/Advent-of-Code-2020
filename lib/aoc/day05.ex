defmodule Aoc.Day05 do
  def task1(input) do
    input
    |> Enum.map(&seat_id/1)
    |> Enum.max()
  end

  def seat_id(boarding_pass) do
    boarding_pass
    |> String.replace(~r/[BR]/, "1")
    |> String.replace(~r/[FL]/, "0")
    |> Integer.parse(2)
    |> elem(0)
  end
end
