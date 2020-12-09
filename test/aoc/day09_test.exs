defmodule Aoc.Day09Test do
  use ExUnit.Case

  alias Aoc.Day09

  describe "&task1/1" do
    test "examples" do
      first_25_numbers = Enum.map(1..25, &Integer.to_string/1)

      assert 100 = Day09.task1(first_25_numbers ++ ["100"])
      assert 60 = Day09.task1(first_25_numbers ++ ["26", "27", "60"])
    end
  end

  describe "&find_first_unsummable/2" do
    test "given a preamble of length 2" do
      assert 6 == Day09.find_first_unsummable([1, 2, 3, 6], 2)
    end

    test "given a preamble of length 3" do
      assert 20 == Day09.find_first_unsummable([1, 2, 3, 5, 7, 20], 3)
    end

    test "example 1" do
      input = [
        35,
        20,
        15,
        25,
        47,
        40,
        62,
        55,
        65,
        95,
        102,
        117,
        150,
        182,
        127,
        219,
        299,
        277,
        309,
        576
      ]

      assert 127 == Day09.find_first_unsummable(input, 5)
    end
  end

  describe "&sum_to?/2" do
    test "given no numbers" do
      assert !Day09.sum_to?([], 3)
    end

    test "given 1 number" do
      assert !Day09.sum_to?([3], 3)
    end

    test "given 2 numbers that sum" do
      assert Day09.sum_to?([2, 3], 5)
    end

    test "given 2 numbers that don't sum" do
      assert !Day09.sum_to?([2, 3], 4)
    end

    test "given 3 numbers that can sum" do
      assert Day09.sum_to?([2, 3, 4], 5)
      assert Day09.sum_to?([2, 3, 4], 6)
      assert Day09.sum_to?([2, 3, 4], 7)
    end

    test "given 3 numbers that can't sum" do
      assert !Day09.sum_to?([2, 3, 4], 2)
      assert !Day09.sum_to?([2, 3, 4], 3)
      assert !Day09.sum_to?([2, 3, 4], 8)
      assert !Day09.sum_to?([2, 3, 4], 10)
    end
  end
end
