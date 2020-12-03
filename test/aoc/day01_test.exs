defmodule Aoc.Day01Test do
  use ExUnit.Case

  describe "&k_combinations/2" do
    test "[] has 0 combinations" do
      assert [] == Aoc.Day01.k_combinations([], 0)
      assert [] == Aoc.Day01.k_combinations([], 1)
      assert [] == Aoc.Day01.k_combinations([], 2)
      assert [] == Aoc.Day01.k_combinations([], -1)
    end

    test "[1,2,3] has three 1-combinations" do
      assert [[1], [2], [3]] == Aoc.Day01.k_combinations([1, 2, 3], 1)
    end

    test "[1,2,3] has one 3-combination" do
      assert [[1, 2, 3]] == Aoc.Day01.k_combinations([1, 2, 3], 3)
    end

    test "[1,2,3] has one 2-combination" do
      assert [[1, 2], [1, 3], [2, 3]] == Aoc.Day01.k_combinations([1, 2, 3], 2)
    end
  end

  describe "&sum2_to/2" do
    test "1 and 3 sum2 to 4" do
      assert {:ok, [1, 3]} == Aoc.Day01.sum2_to(4, [1, 2, 3, 4])
    end

    test "1, 2 and 3 don't sum2 to 6" do
      assert :error == Aoc.Day01.sum2_to(6, [1, 2, 3])
    end

    test "1 and 5 sum2 to 6" do
      assert {:ok, [1, 5]} == Aoc.Day01.sum2_to(6, [1, 2, 3, 4, 5])
    end

    test "2 does not sum2 to 4" do
      assert :error == Aoc.Day01.sum2_to(4, [2])
    end
  end

  describe "&sum3_to/2" do
    test "[1,2,3,4] don't sum3 to 4" do
      assert :error == Aoc.Day01.sum3_to(4, [1, 2, 3, 4])
    end

    test "1, 2 and 3 sum3 to 6" do
      assert {:ok, [1, 2, 3]} == Aoc.Day01.sum3_to(6, [1, 2, 3, 4, 5])
    end

    test "2 doesn't sum3 to 4" do
      assert :error == Aoc.Day01.sum3_to(4, [2])
    end
  end
end
