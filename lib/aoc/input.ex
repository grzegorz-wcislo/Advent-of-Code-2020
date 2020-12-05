defmodule Aoc.Input do
  def read_lines(filename) do
    File.stream!(filename)
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
  end
end
