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

  describe "&task2/1" do
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

      assert 336 == Aoc.Day03.task2(input)
    end
  end

  describe "&count_trees/3" do
    test "counts trees straight down" do
      input = [
        ".##",
        "###",
        ".##"
      ]

      assert 1 == Aoc.Day03.count_trees(input, 0, 1)
      assert 0 == Aoc.Day03.count_trees(input, 0, 2)
    end

    test "counts trees on an angle" do
      input = [
        ".##",
        "###",
        ".##"
      ]

      assert 2 == Aoc.Day03.count_trees(input, 2, 1)
      assert 1 == Aoc.Day03.count_trees(input, 2, 2)
    end
  end

  describe "&keep_nth/2" do
    test "returns all elements given n = 1" do
      input = [1, 2, 3, 4, 5]

      assert [1, 2, 3, 4, 5] == Aoc.Day03.keep_nth(input, 1)
    end

    test "returns every second element given n = 2" do
      input = [1, 2, 3, 4, 5]

      assert [1, 3, 5] == Aoc.Day03.keep_nth(input, 2)
    end

    test "returns every third element given n = 3" do
      input = [1, 2, 3, 4, 5]

      assert [1, 4] == Aoc.Day03.keep_nth(input, 3)
    end
  end
end
