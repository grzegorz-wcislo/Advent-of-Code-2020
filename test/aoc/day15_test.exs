defmodule Aoc.Day15Test do
  use ExUnit.Case

  alias Aoc.Day15

  describe "&task1/1" do
    test "examples" do
      assert 436 == Day15.task1(["0,3,6"])
      assert 1 == Day15.task1(["1,3,2"])
      assert 10 == Day15.task1(["2,1,3"])
      assert 27 == Day15.task1(["1,2,3"])
      assert 78 == Day15.task1(["2,3,1"])
      assert 438 == Day15.task1(["3,2,1"])
      assert 1836 == Day15.task1(["3,1,2"])
    end
  end

  describe "&get_nth_number/2" do
    test "given n smaller than starting numbers size" do
      assert 0 == Day15.get_nth_number([0, 3, 6], 1)
      assert 3 == Day15.get_nth_number([0, 3, 6], 2)
      assert 6 == Day15.get_nth_number([0, 3, 6], 3)
    end

    test "given largen ns" do
      assert 0 == Day15.get_nth_number([0, 3, 6], 4)
      assert 3 == Day15.get_nth_number([0, 3, 6], 5)
      assert 3 == Day15.get_nth_number([0, 3, 6], 6)
      assert 1 == Day15.get_nth_number([0, 3, 6], 7)
      assert 0 == Day15.get_nth_number([0, 3, 6], 8)
      assert 4 == Day15.get_nth_number([0, 3, 6], 9)
      assert 0 == Day15.get_nth_number([0, 3, 6], 10)
    end
  end
end
