defmodule Aoc.Day05Test do
  use ExUnit.Case

  describe "&task1/1" do
    test "example 1" do
      input = [
        "BFFFBBFRRR",
        "BBFFBBFRLL",
        "FFFBBBFRRR"
      ]

      assert 820 == Aoc.Day05.task1(input)
    end
  end

  describe "&seat_id/1" do
    test "example 1" do
      assert 567 == Aoc.Day05.seat_id("BFFFBBFRRR")
    end

    test "example 2" do
      assert 119 == Aoc.Day05.seat_id("FFFBBBFRRR")
    end

    test "example 3" do
      assert 820 == Aoc.Day05.seat_id("BBFFBBFRLL")
    end
  end
end
