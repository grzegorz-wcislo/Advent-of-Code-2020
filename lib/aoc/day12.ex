defmodule Aoc.Day12 do
  def task1(input) do
    {x, y, _} =
      input
      |> Enum.map(&parse_instruction/1)
      |> Enum.reduce({0, 0, 0}, &handle_instruction(&2, &1))

    abs(x) + abs(y)
  end

  def task2(input) do
    {x, y, _, _} =
      input
      |> Enum.map(&parse_instruction/1)
      |> Enum.reduce({0, 0, 10, 1}, &handle_instruction_waypoint(&2, &1))

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

  def handle_instruction({x, y, r}, {:N, v}), do: {x, y + v, r}
  def handle_instruction({x, y, r}, {:E, v}), do: {x + v, y, r}
  def handle_instruction({x, y, r}, {:S, v}), do: {x, y - v, r}
  def handle_instruction({x, y, r}, {:W, v}), do: {x - v, y, r}
  def handle_instruction({x, y, r}, {:L, v}), do: {x, y, rem(r + v, 360)}
  def handle_instruction({x, y, r}, {:R, v}), do: {x, y, rem(360 + r - v, 360)}
  def handle_instruction({x, y, 0}, {:F, v}), do: {x + v, y, 0}
  def handle_instruction({x, y, 90}, {:F, v}), do: {x, y + v, 90}
  def handle_instruction({x, y, 180}, {:F, v}), do: {x - v, y, 180}
  def handle_instruction({x, y, 270}, {:F, v}), do: {x, y - v, 270}

  def handle_instruction_waypoint({x, y, wx, wy}, {:N, v}), do: {x, y, wx, wy + v}
  def handle_instruction_waypoint({x, y, wx, wy}, {:E, v}), do: {x, y, wx + v, wy}
  def handle_instruction_waypoint({x, y, wx, wy}, {:S, v}), do: {x, y, wx, wy - v}
  def handle_instruction_waypoint({x, y, wx, wy}, {:W, v}), do: {x, y, wx - v, wy}
  def handle_instruction_waypoint({x, y, wx, wy}, {:L, 0}), do: {x, y, wx, wy}
  def handle_instruction_waypoint({x, y, wx, wy}, {:L, 90}), do: {x, y, -wy, wx}
  def handle_instruction_waypoint({x, y, wx, wy}, {:L, 180}), do: {x, y, -wx, -wy}
  def handle_instruction_waypoint({x, y, wx, wy}, {:L, 270}), do: {x, y, wy, -wx}
  def handle_instruction_waypoint({x, y, wx, wy}, {:R, 0}), do: {x, y, wx, wy}
  def handle_instruction_waypoint({x, y, wx, wy}, {:R, 90}), do: {x, y, wy, -wx}
  def handle_instruction_waypoint({x, y, wx, wy}, {:R, 180}), do: {x, y, -wx, -wy}
  def handle_instruction_waypoint({x, y, wx, wy}, {:R, 270}), do: {x, y, -wy, wx}
  def handle_instruction_waypoint({x, y, wx, wy}, {:F, v}), do: {x + v * wx, y + v * wy, wx, wy}
end
