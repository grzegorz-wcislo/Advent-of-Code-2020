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

  describe "&task2/1" do
    input = [
      "mask = 000000000000000000000000000000X1001X",
      "mem[42] = 100",
      "mask = 00000000000000000000000000000000X0XX",
      "mem[26] = 1"
    ]

    assert 208 == Day14.task2(input)
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

  describe "&floating_address/2" do
    test "example 1" do
      assert "0X1101X" == Day14.floating_address("0101010", "0X1001X")
    end

    test "example 2" do
      assert "01X0XX" == Day14.floating_address("011010", "00X0XX")
    end
  end

  describe "&real_addresses/1" do
    test "given a non floating address" do
      assert MapSet.equal?(
               MapSet.new(["0101"]),
               MapSet.new(Day14.real_addresses("0101"))
             )
    end

    test "given a floating address" do
      assert MapSet.equal?(
               MapSet.new(["0001", "0011", "0101", "0111"]),
               MapSet.new(Day14.real_addresses("0XX1"))
             )
    end
  end
end
