defmodule Aoc.Day03Test do
  use ExUnit.Case

  describe "&task1/1" do
    test "example" do
      input = [
        "..##.......",
        "#...#...#..",
        ".#....#..#.",
        "..#.#...#.#",
        ".#...##..#.",
        "..#.##.....",
        ".#.#.#....#",
        ".#........#",
        "#.##...#...",
        "#...##....#",
        ".#..#...#.#"
      ]

      assert 7 == Aoc.Day03.task1(input)
    end
  end
end
