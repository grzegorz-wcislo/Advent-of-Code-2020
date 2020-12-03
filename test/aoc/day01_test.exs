defmodule Aoc.Day01Test do
  use ExUnit.Case

  test "1 and 3 sum2 to 4" do
    assert {:ok, {1, 3}} == Aoc.Day01.sum2_to(4, [1, 2, 3, 4])
  end

  test "1, 2 and 3 don't sum2 to 6" do
    assert :error == Aoc.Day01.sum2_to(6, [1, 2, 3])
  end

  test "2 does not sum2 to 4" do
    assert :error == Aoc.Day01.sum2_to(4, [2])
  end
end
