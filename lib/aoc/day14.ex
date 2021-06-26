defmodule Aoc.Day14 do
  @moduledoc false

  use Bitwise

  def task1(input) do
    task_with_reducer(input, &mem_reducer/2)
  end

  def task2(input) do
    task_with_reducer(input, &mem_reducer2/2)
  end

  defp task_with_reducer(input, reducer) do
    input
    |> Enum.map(&parse_line/1)
    |> Enum.reduce({"", %{}}, reducer)
    |> elem(1)
    |> Map.values()
    |> Enum.sum()
  end

  defp mem_reducer({:mask, mask}, {_, memory}), do: {mask, memory}

  defp mem_reducer({:mem, address, value}, {mask, memory}) do
    {mask, Map.put(memory, address, apply_mask(value, mask))}
  end

  defp mem_reducer2({:mask, mask}, {_, memory}), do: {mask, memory}

  defp mem_reducer2({:mem, address, value}, {mask, memory}) do
    addresses =
      address
      |> Integer.to_string(2)
      |> String.pad_leading(36, "0")
      |> floating_address(mask)
      |> real_addresses()

    {
      mask,
      Enum.reduce(addresses, memory, &Map.put(&2, &1, value))
    }
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

  def floating_address(address, mask) do
    Enum.zip(String.graphemes(address), String.graphemes(mask))
    |> Enum.map(fn
      {v, "0"} -> v
      {_, m} -> m
    end)
    |> Enum.join()
  end

  def real_addresses(floating_address) do
    do_real_addresses([floating_address])
  end

  defp do_real_addresses(addresses) do
    if Regex.match?(~r/X/, hd(addresses)) do
      do_real_addresses(
        addresses
        |> Enum.flat_map(fn address ->
          [
            String.replace(address, "X", "0", global: false),
            String.replace(address, "X", "1", global: false)
          ]
        end)
      )
    else
      addresses
    end
  end
end
