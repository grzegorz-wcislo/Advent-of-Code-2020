defmodule Aoc.Day13Test do
  use ExUnit.Case

  alias Aoc.Day13

  describe "&task1/1" do
    test "example 1" do
      assert 295 == Day13.task1(["939", "7,13,x,x,59,x,31,19"])
    end
  end

  describe "&task2/1" do
    test "example 1" do
      assert 1_068_781 == Day13.task2(["939", "7,13,x,x,59,x,31,19"])
    end

    test "example 2" do
      assert 3417 == Day13.task2(["", "17,x,13,19"])
    end

    test "example 3" do
      assert 754_018 == Day13.task2(["", "67,7,59,61"])
    end

    test "example 4" do
      assert 779_210 == Day13.task2(["", "67,x,7,59,61"])
    end

    test "example 5" do
      assert 1_261_476 == Day13.task2(["", "67,7,x,59,61"])
    end

    test "example 6" do
      assert 1_202_161_486 == Day13.task2(["", "1789,37,47,1889"])
    end
  end

  describe "&parse_input/1" do
    test "example 1" do
      input = ["939", "7,13,x,x,59,x,31,19"]

      assert {939, [7, 13, 59, 31, 19]} == Day13.parse_input(input)
    end
  end

  describe "&parse_input2/1" do
    test "example 1" do
      input = ["939", "7,13,x,x,59,x,31,19"]

      assert [{0, 7}, {-1, 13}, {-4, 59}, {-6, 31}, {-7, 19}] == Day13.parse_input2(input)
    end
  end

  describe "&nearest_departure_after/2" do
    test "given a departure right on time" do
      assert 15 == Day13.nearest_departure_after(5, 15)
      assert 16 == Day13.nearest_departure_after(4, 16)
    end

    test "given a later departure" do
      assert 16 == Day13.nearest_departure_after(4, 15)
      assert 22 == Day13.nearest_departure_after(11, 21)
      assert 944 == Day13.nearest_departure_after(59, 939)
    end
  end

  describe "&crt_solve/1" do
    test "given 2 equations" do
      assert 3 == Day13.crt_solve([{0, 3}, {3, 4}])
      assert 3 == Day13.crt_solve([{0, 3}, {-1, 4}])
    end

    test "given 3 equations" do
      assert 39 == Day13.crt_solve([{0, 3}, {3, 4}, {4, 5}])
    end

    test "example" do
      assert 3417 == Day13.crt_solve([{0, 17}, {11, 13}, {16, 19}])
      assert 3417 == Day13.crt_solve([{0, 17}, {-2, 13}, {-3, 19}])
    end
  end

  describe "&extended_gcd/2" do
    test "example 1" do
      assert {-1, 1, 1} == Day13.extended_gcd(3, 4)
    end

    test "example 2" do
      assert {1, -1, 2} == Day13.extended_gcd(6, 4)
    end

    test "example 3" do
      assert {-9, 2, 1} == Day13.extended_gcd(13, 59)
    end
  end
end
