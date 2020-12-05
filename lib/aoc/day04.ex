defmodule Aoc.Day04 do
  def task1(input) do
    required_keys = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

    input
    |> join_nonempty
    |> extract_keys
    |> Enum.filter(&contains_required_keys?(&1, required_keys))
    |> length
  end

  def join_nonempty(input) do
    Enum.reduce(input, [""], fn line, acc ->
      case line do
        "" ->
          ["" | acc]

        _ ->
          [head | tail] = acc

          case head do
            "" -> [line | tail]
            _ -> [head <> " " <> line | tail]
          end
      end
    end)
    |> Enum.reverse()
  end

  def extract_keys(passports) when is_list(passports) do
    Enum.map(passports, &extract_keys/1)
  end

  def extract_keys(passport) do
    String.split(passport, ~r/ +/)
    |> Enum.map(&String.split(&1, ":"))
    |> Enum.map(&hd/1)
  end

  def contains_required_keys?(passport_keys, required_keys) do
    MapSet.difference(
      MapSet.new(required_keys),
      MapSet.new(passport_keys)
    ) == MapSet.new()
  end
end
