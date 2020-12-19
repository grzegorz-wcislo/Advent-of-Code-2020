defmodule Aoc.Day18 do
  def task1(input) do
    input
    |> Enum.map(&evaluate/1)
    |> Enum.sum()
  end

  def task2(input) do
    input
    |> Enum.map(&evaluate_advanced/1)
    |> Enum.sum()
  end

  def evaluate(expression) do
    expression
    |> tokenize()
    |> Enum.reduce([[]], &evaluate_reducer/2)
    |> hd()
    |> hd()
  end

  def evaluate_advanced(expression) do
    expression
    |> tokenize()
    |> Enum.chunk_every(2, 1)
    |> Enum.reduce([[]], &advanced_reducer/2)
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

  defp advanced_reducer([token, "+"], [["*" | rest] | state]) when is_integer(token) do
    [[token, "*" | rest] | state]
  end

  defp advanced_reducer([token | _next], [["*", other | rest] | state]) when is_integer(token) do
    [[token * other | rest] | state]
  end

  defp advanced_reducer([token, "+"], [["+", other | rest] | state]) when is_integer(token) do
    [[token + other | rest] | state]
  end

  defp advanced_reducer([token | _next], [["+", other, "*", rest] | state])
       when is_integer(token) do
    [[(token + other) * rest] | state]
  end

  defp advanced_reducer([token | _next], [["+", other | rest] | state]) when is_integer(token) do
    [[token + other | rest] | state]
  end

  defp advanced_reducer(["*" | _next], [[a, "*", b]]) do
    [["*", a * b]]
  end

  defp advanced_reducer(["(" | _next], state), do: [[] | state]

  defp advanced_reducer([")" | next], [[token] | state]),
    do: advanced_reducer([token | next], state)

  defp advanced_reducer([token | _next], [top | state]), do: [[token | top] | state]
end
