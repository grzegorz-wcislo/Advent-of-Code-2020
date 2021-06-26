defmodule Aoc.Day02 do
  @moduledoc false

  def task1(password_lines) do
    password_lines
    |> count_validated_with(&is_valid1?/1)
  end

  def task2(password_lines) do
    password_lines
    |> count_validated_with(&is_valid2?/1)
  end

  def count_validated_with(password_lines, validator) do
    password_lines
    |> Enum.map(&parse_password_line/1)
    |> Enum.flat_map(fn parsed_password ->
      case parsed_password do
        {:ok, password} -> [password]
        _ -> []
      end
    end)
    |> Enum.filter(validator)
    |> length
  end

  def parse_password_line(line) do
    line_regex = ~r/^([[:digit:]]+)-([[:digit:]]+) ([[:lower:]]): ([[:lower:]]+)$/

    case Regex.run(line_regex, line, capture: :all_but_first) do
      [min, max, char, password] ->
        {:ok,
         {{
            String.to_integer(min),
            String.to_integer(max),
            char
          }, password}}

      _ ->
        :error
    end
  end

  def is_valid1?({{min, max, char}, password}) do
    {:ok, char_regex} = Regex.compile(char)

    matches = length(Regex.scan(char_regex, password, capture: :first))

    matches >= min and matches <= max
  end

  def is_valid2?({{min, max, char}, password}) do
    matches = [
      String.slice(password, min - 1, 1) == char,
      String.slice(password, max - 1, 1) == char
    ]

    case matches do
      [true, false] -> true
      [false, true] -> true
      _ -> false
    end
  end
end
