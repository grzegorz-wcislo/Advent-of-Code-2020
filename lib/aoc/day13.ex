defmodule Aoc.Day13 do
  @moduledoc false

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

  def task2(input) do
    input
    |> parse_input2()
    |> crt_solve()
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

  def parse_input2([_, busses]) do
    busses
    |> String.split(",")
    |> Enum.with_index()
    |> Enum.filter(fn
      {"x", _} -> false
      _ -> true
    end)
    |> Enum.map(fn {bus, time} ->
      {-time, String.to_integer(bus)}
    end)
  end

  def nearest_departure_after(bus, timestamp) do
    timestamp + rem(bus - rem(timestamp, bus), bus)
  end

  def crt_solve(equations) do
    equations
    |> Enum.reduce(fn {a1, n1}, {a2, n2} ->
      {crt_solve2({a1, n1}, {a2, n2}), n1 * n2}
    end)
    |> elem(0)
  end

  defp crt_solve2({a1, n1}, {a2, n2}) do
    {x, y, 1} = extended_gcd(n1, n2)
    solution = a2 * x * n1 + a1 * y * n2

    mul = n1 * n2
    rem(rem(solution, mul) + mul, mul)
  end

  def extended_gcd(a, b) do
    do_extended_gcd(a, b, 1, 0, 0, 1)
  end

  defp do_extended_gcd(old_r, 0, old_s, _, old_t, _), do: {old_s, old_t, old_r}

  defp do_extended_gcd(old_r, r, old_s, s, old_t, t) do
    quotient = div(old_r, r)

    do_extended_gcd(
      r,
      old_r - quotient * r,
      s,
      old_s - quotient * s,
      t,
      old_t - quotient * t
    )
  end
end
