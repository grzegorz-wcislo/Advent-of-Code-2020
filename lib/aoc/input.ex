defmodule Aoc.Input do
  @moduledoc """
  Reads contents of an Advent of Code input file.
  """

  def read_lines(filename) do
    File.stream!(filename)
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
  end
end
