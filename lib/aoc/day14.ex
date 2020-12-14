defmodule Aoc.Day14 do
  use Bitwise

  def task1(input) do
    input
    |> Enum.map(&parse_line/1)
    |> Enum.reduce({"", %{}}, &mem_reducer/2)
    |> elem(1)
    |> Map.values()
    |> Enum.sum()
  end

  defp mem_reducer({:mask, mask}, {_, memory}), do: {mask, memory}

  defp mem_reducer({:mem, address, value}, {mask, memory}) do
    {mask, Map.put(memory, address, apply_mask(value, mask))}
  end

  def parse_line(line) do
    mem_regex = ~r/^mem\[([[:digit:]]+)\] = ([[:digit:]]+)$/
    mask_regex = ~r/^mask = ([01X]+)$/

    case Regex.run(mem_regex, line, capture: :all_but_first) do
      [address, value] ->
        {:mem, String.to_integer(address), String.to_integer(value)}

      nil ->
        case Regex.run(mask_regex, line, capture: :all_but_first) do
          [mask] -> {:mask, mask}
        end
    end
  end

  def apply_mask(number, mask) do
    or_filter = mask |> String.replace("X", "0") |> String.to_integer(2)
    and_filter = mask |> String.replace("X", "1") |> String.to_integer(2)

    (number ||| or_filter) &&& and_filter
  end
end
