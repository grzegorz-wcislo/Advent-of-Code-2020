defmodule Aoc.Day10Test do
  use ExUnit.Case

  alias Aoc.Day10

  describe "&task1/1" do
    test "example 1" do
      input = "16 10 15 5 1 11 7 19 6 12 4" |> String.split(" ")

      assert 35 == Day10.task1(input)
    end

    test "example 2" do
      input =
        "28 33 18 42 31 14 46 20 48 47 24 23 49 45 19 38 39 11 1 32 25 35 8 17 7 9 4 2 34 10 3"
        |> String.split(" ")

      assert 220 = Day10.task1(input)
    end
  end

  describe "&task2/1" do
    test "example 1" do
      input = "16 10 15 5 1 11 7 19 6 12 4" |> String.split(" ")

      assert 8 == Day10.task2(input)
    end

    test "example 2" do
      input =
        "28 33 18 42 31 14 46 20 48 47 24 23 49 45 19 38 39 11 1 32 25 35 8 17 7 9 4 2 34 10 3"
        |> String.split(" ")

      assert 19208 == Day10.task2(input)
    end
  end

  describe "&calculate_differences/1" do
    test "given 0 inputs" do
      assert [] == Day10.calculate_differences([])
    end

    test "given 1 input" do
      assert [] == Day10.calculate_differences([2])
    end

    test "given 2 inputs" do
      assert [3] == Day10.calculate_differences([1, 4])
      assert [-2] == Day10.calculate_differences([5, 3])
    end

    test "given more inputs" do
      assert [3, 2, -4, 8] == Day10.calculate_differences([1, 4, 6, 2, 10])
      assert [-2, -13, 110] == Day10.calculate_differences([5, 3, -10, 100])
    end
  end

  describe "&count_ones_threes/1" do
    test "given 0 inputs" do
      assert {0, 0} == Day10.count_ones_threes([])
    end

    test "given no 1 or 3" do
      assert {0, 0} == Day10.count_ones_threes([0, 2, 4, 5, 6])
    end

    test "given some 1s and 3s" do
      assert {2, 3} == Day10.count_ones_threes([0, 1, 3, 2, 1, 3, 4, 3, 5, 6])
      assert {3, 2} == Day10.count_ones_threes([0, 1, 1, 2, 1, 3, 4, 3, 5, 6])
    end
  end

  describe "&fib3/1" do
    test "elem 0" do
      assert 0 == Day10.fib3(0)
    end

    test "elem 1" do
      assert 1 == Day10.fib3(1)
    end

    test "elem 2" do
      assert 1 == Day10.fib3(2)
    end

    test "elem 3" do
      assert 2 == Day10.fib3(3)
    end

    test "elem 4" do
      assert 4 == Day10.fib3(4)
    end

    test "elem 5" do
      assert 7 == Day10.fib3(5)
    end

    test "elem 30" do
      assert 29_249_425 == Day10.fib3(30)
    end
  end
end
