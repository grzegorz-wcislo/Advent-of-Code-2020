defmodule Aoc.Day12Test do
  use ExUnit.Case

  alias Aoc.Day12

  describe "&task1/1" do
    test "example 1" do
      input = [
        "F10",
        "N3",
        "F7",
        "R90",
        "F11"
      ]

      assert 25 == Day12.task1(input)
    end
  end

  describe "&parse_instruction" do
    test "valid instructions" do
      assert {:N, 23} == Day12.parse_instruction("N23")
      assert {:E, 423} == Day12.parse_instruction("E423")
      assert {:S, 13} == Day12.parse_instruction("S13")
      assert {:W, 35} == Day12.parse_instruction("W35")
      assert {:L, 7} == Day12.parse_instruction("L7")
      assert {:R, 100} == Day12.parse_instruction("R100")
      assert {:F, 16} == Day12.parse_instruction("F16")
    end

    test "invalid instructions" do
      assert_raise(MatchError, fn -> Day12.parse_instruction("D16") end)
      assert_raise(MatchError, fn -> Day12.parse_instruction("D") end)
      assert_raise(MatchError, fn -> Day12.parse_instruction("w16") end)
      assert_raise(MatchError, fn -> Day12.parse_instruction("123") end)
    end
  end

  describe "&handle_instruction/2" do
    test "north instruction" do
      assert {1, 11, 0} == Day12.handle_instruction({1, 2, 0}, {:N, 9})
      assert {2, 13, 270} == Day12.handle_instruction({2, 3, 270}, {:N, 10})
    end

    test "east instruction" do
      assert {11, 3, 90} == Day12.handle_instruction({2, 3, 90}, {:E, 9})
      assert {11, 5, 180} == Day12.handle_instruction({1, 5, 180}, {:E, 10})
    end

    test "south instruction" do
      assert {2, -8, 90} == Day12.handle_instruction({2, 1, 90}, {:S, 9})
      assert {1, -5, 270} == Day12.handle_instruction({1, 5, 270}, {:S, 10})
    end

    test "west instruction" do
      assert {-8, 5, 0} == Day12.handle_instruction({1, 5, 0}, {:W, 9})
      assert {-3, 2, 90} == Day12.handle_instruction({7, 2, 90}, {:W, 10})
    end

    test "left instruction" do
      assert {1, 3, 90} == Day12.handle_instruction({1, 3, 0}, {:L, 90})
      assert {4, 2, 270} == Day12.handle_instruction({4, 2, 180}, {:L, 90})
      assert {2, 8, 0} == Day12.handle_instruction({2, 8, 270}, {:L, 90})
    end

    test "right instruction" do
      assert {1, 3, 0} == Day12.handle_instruction({1, 3, 90}, {:R, 90})
      assert {4, 2, 180} == Day12.handle_instruction({4, 2, 270}, {:R, 90})
      assert {2, 8, 270} == Day12.handle_instruction({2, 8, 0}, {:R, 90})
    end

    test "front instruction" do
      assert {10, 2, 0} == Day12.handle_instruction({1, 2, 0}, {:F, 9})
      assert {1, 11, 90} == Day12.handle_instruction({1, 2, 90}, {:F, 9})
      assert {-8, 2, 180} == Day12.handle_instruction({1, 2, 180}, {:F, 9})
      assert {1, -7, 270} == Day12.handle_instruction({1, 2, 270}, {:F, 9})
    end
  end
end
