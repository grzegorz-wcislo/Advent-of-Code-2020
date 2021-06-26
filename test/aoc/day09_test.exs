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

  describe "&task2/1" do
    test "examples" do
      first_25_numbers = Enum.map(1..25, &Integer.to_string/1)

      assert 25 = Day09.task2(first_25_numbers ++ ["100"])
      assert 15 = Day09.task2(first_25_numbers ++ ["26", "27", "60"])
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

  describe "&find_encryption_weakness/2" do
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

      assert 62 == Day09.find_encryption_weakness(input, 5)
    end
  end

  describe "&sum_to?/2" do
    test "given no numbers" do
      refute Day09.sum_to?([], 3)
    end

    test "given 1 number" do
      refute Day09.sum_to?([3], 3)
    end

    test "given 2 numbers that sum" do
      assert Day09.sum_to?([2, 3], 5)
    end

    test "given 2 numbers that don't sum" do
      refute Day09.sum_to?([2, 3], 4)
    end

    test "given 3 numbers that can sum" do
      assert Day09.sum_to?([2, 3, 4], 5)
      assert Day09.sum_to?([2, 3, 4], 6)
      assert Day09.sum_to?([2, 3, 4], 7)
    end

    test "given 3 numbers that can't sum" do
      refute Day09.sum_to?([2, 3, 4], 2)
      refute Day09.sum_to?([2, 3, 4], 3)
      refute Day09.sum_to?([2, 3, 4], 8)
      refute Day09.sum_to?([2, 3, 4], 10)
    end
  end

  describe "&find_contigous_sum/2" do
    test "given ordered numbers" do
      assert [3, 4] == Day09.find_contigous_sum([1, 2, 3, 4, 5], 7)
    end

    test "given reverse ordered numbers" do
      assert [4, 3] == Day09.find_contigous_sum([5, 4, 3, 2, 1], 7)
    end

    test "given randomly ordered numbers" do
      assert [3, 2, 1, 1] == Day09.find_contigous_sum([10, 20, 3, 2, 8, 3, 2, 1, 1, 4], 7)
    end
  end
end
