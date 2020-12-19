defmodule Aoc.Day19 do
  def task1(input) do
    input
    |> Enum.map(&evaluate/1)
    |> Enum.sum()
  end

  def evaluate(expression) do
    expression
    |> tokenize()
    |> Enum.reduce([[]], &evaluate_reducer/2)
    |> hd()
    |> hd()
  end

  defp tokenize(expression) do
    Regex.scan(~r/[()+*]|\d+/, expression)
    |> Enum.map(&hd/1)
    |> Enum.map(fn token ->
      case Integer.parse(token) do
        {i, ""} -> i
        :error -> token
      end
    end)
  end

  defp evaluate_reducer(token, [["+", other] | state]) when is_integer(token) do
    [[token + other] | state]
  end

  defp evaluate_reducer(token, [["*", other] | state]) when is_integer(token) do
    [[token * other] | state]
  end

  defp evaluate_reducer("(", state), do: [[] | state]

  defp evaluate_reducer(")", [[token] | state]), do: evaluate_reducer(token, state)

  defp evaluate_reducer(token, [top | state]), do: [[token | top] | state]
end
