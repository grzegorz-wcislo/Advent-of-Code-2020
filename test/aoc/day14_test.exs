defmodule Aoc.Day14Test do
  use ExUnit.Case

  alias Aoc.Day14

  describe "&task1/1" do
    input = [
      "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X",
      "mem[8] = 14",
      "mem[7] = 101",
      "mem[8] = 0"
    ]

    assert 165 == Day14.task1(input)
  end

  describe "&parse_line/1" do
    test "memory instruction" do
      assert {:mem, 8, 23} == Day14.parse_line("mem[8] = 23")
    end

    test "mask instruction" do
      assert {:mask, "00XX11X0"} == Day14.parse_line("mask = 00XX11X0")
    end
  end

  describe "&apply_mask/2" do
    test "example 1" do
      assert String.to_integer("10010", 2) ==
               Day14.apply_mask(String.to_integer("01010"), "10X1X")
    end

    test "example 2" do
      assert String.to_integer("10111", 2) ==
               Day14.apply_mask(String.to_integer("10101"), "10X1X")
    end
  end
end
