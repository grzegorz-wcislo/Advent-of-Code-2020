defmodule Aoc.Day13Test do
  use ExUnit.Case

  alias Aoc.Day13

  describe "&task1/1" do
    test "example 1" do
      input = ["939", "7,13,x,x,59,x,31,19"]

      assert 295 == Day13.task1(input)
    end
  end

  describe "&parse_input/1" do
    test "example 1" do
      input = ["939", "7,13,x,x,59,x,31,19"]

      assert {939, [7, 13, 59, 31, 19]} == Day13.parse_input(input)
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
end
