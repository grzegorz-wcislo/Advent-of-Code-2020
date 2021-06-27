defmodule Aoc.Day17Test do
  use ExUnit.Case

  alias Aoc.Day17

  describe "&task1/1" do
    test "example 1" do
      input = [
        ".#.",
        "..#",
        "###"
      ]

      assert 112 == Day17.task1(input)
    end
  end

  describe "&parse_input/1" do
    test "example 1" do
      input = [
        ".#.",
        "..#",
        "###"
      ]

      result =
        MapSet.new([
          {1, 0, 0},
          {2, 1, 0},
          {0, 2, 0},
          {1, 2, 0},
          {2, 2, 0}
        ])

      assert result == Day17.parse_input(input)
    end
  end

  describe "&step/1" do
    test "example 1" do
      active =
        MapSet.new([
          {1, 0, 0},
          {2, 1, 0},
          {0, 2, 0},
          {1, 2, 0},
          {2, 2, 0}
        ])

      next =
        MapSet.new([
          {0, 1, -1},
          {0, 1, 0},
          {0, 1, 1},
          {1, 2, 0},
          {1, 3, -1},
          {1, 3, 0},
          {1, 3, 1},
          {2, 1, 0},
          {2, 2, -1},
          {2, 2, 0},
          {2, 2, 1}
        ])

      assert next == Day17.step(active)
    end
  end
end
