defmodule Aoc.Day04 do
  @required_keys ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

  def task1(input) do
    input
    |> join_nonempty
    |> extract_keys
    |> Enum.filter(&contains_required_keys?(&1, @required_keys))
    |> length
  end

  def task2(input) do
    input
    |> join_nonempty()
    |> extract_entries()
    |> Enum.filter(&contains_required_keys?(Map.keys(&1), @required_keys))
    |> Enum.filter(&contains_valid_values?/1)
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

  def extract_entries(passports) when is_list(passports) do
    Enum.map(passports, &extract_entries/1)
  end

  def extract_entries(passport) do
    String.split(passport, ~r/ +/)
    |> Enum.map(&String.split(&1, ":"))
    |> Map.new(fn [k, v] -> {k, v} end)
  end

  def contains_required_keys?(passport_keys, required_keys) do
    MapSet.subset?(MapSet.new(required_keys), MapSet.new(passport_keys))
  end

  def contains_valid_values?(passport) do
    passport
    |> Map.to_list()
    |> Enum.all?(fn {field, value} ->
      case field do
        "byr" ->
          in_range?(value, 1920, 2002)

        "iyr" ->
          in_range?(value, 2010, 2020)

        "eyr" ->
          in_range?(value, 2020, 2030)

        "hgt" ->
          case Integer.parse(value) do
            {height, "cm"} -> height >= 150 && height <= 193
            {height, "in"} -> height >= 59 && height <= 76
            _ -> false
          end

        "hcl" ->
          String.match?(value, ~r/^#[0-9a-f]{6}$/)

        "ecl" ->
          String.match?(value, ~r/^(amb|blu|brn|gry|grn|hzl|oth)$/)

        "pid" ->
          String.match?(value, ~r/^[0-9]{9}$/)

        _ ->
          true
      end
    end)
  end

  defp in_range?(value, min, max) do
    case Integer.parse(value) do
      {year, ""} -> year >= min && year <= max
      _ -> false
    end
  end
end
