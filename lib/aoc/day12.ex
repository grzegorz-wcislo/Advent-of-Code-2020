defmodule Aoc.Day12 do
  def task1(input) do
    {x, y, _} =
      input
      |> Enum.map(&parse_instruction/1)
      |> Enum.reduce({0, 0, 0}, &handle_instruction(&2, &1))

    abs(x) + abs(y)
  end

  def parse_instruction(instruction) do
    [dir, value] =
      Regex.run(~r/^([NESWLRF])([[:digit:]]+)$/, instruction, capture: :all_but_first)

    {
      String.to_atom(dir),
      String.to_integer(value)
    }
  end

  def handle_instruction({x, y, rotation}, {:N, value}), do: {x, y + value, rotation}

  def handle_instruction({x, y, rotation}, {:E, value}), do: {x + value, y, rotation}

  def handle_instruction({x, y, rotation}, {:S, value}), do: {x, y - value, rotation}

  def handle_instruction({x, y, rotation}, {:W, value}), do: {x - value, y, rotation}

  def handle_instruction({x, y, rotation}, {:L, value}),
    do: {x, y, rem(rotation + value, 360)}

  def handle_instruction({x, y, rotation}, {:R, value}),
    do: {x, y, rem(360 + rotation - value, 360)}

  def handle_instruction({x, y, rotation}, {:F, value}) do
    case rotation do
      0 -> {x + value, y, rotation}
      90 -> {x, y + value, rotation}
      180 -> {x - value, y, rotation}
      270 -> {x, y - value, rotation}
    end
  end
end
