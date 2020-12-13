defmodule Aoc.Day13 do
  def task1(input) do
    {timestamp, busses} = parse_input(input)

    {earliest_bus, earliest_timestamp} =
      busses
      |> Enum.map(fn bus ->
        {bus, nearest_departure_after(bus, timestamp)}
      end)
      |> Enum.min_by(&elem(&1, 1))

    earliest_bus * (earliest_timestamp - timestamp)
  end

  def parse_input([timestamp, busses]) do
    {
      String.to_integer(timestamp),
      busses
      |> String.split(",")
      |> Enum.filter(&(&1 != "x"))
      |> Enum.map(&String.to_integer/1)
    }
  end

  def nearest_departure_after(bus, timestamp) do
    timestamp + rem(bus - rem(timestamp, bus), bus)
  end
end
