defmodule Aoc.Day11Test do
  use ExUnit.Case

  alias Aoc.Day11

  describe "&task1/1" do
    test "example 1" do
      input = [
        "L.LL.LL.LL",
        "LLLLLLL.LL",
        "L.L.L..L..",
        "LLLL.LL.LL",
        "L.LL.LL.LL",
        "L.LLLLL.LL",
        "..L.L.....",
        "LLLLLLLLLL",
        "L.LLLLLL.L",
        "L.LLLLL.LL"
      ]

      assert 37 == Day11.task1(input)
    end
  end

  describe "&task2/1" do
    test "example 1" do
      input = [
        "L.LL.LL.LL",
        "LLLLLLL.LL",
        "L.L.L..L..",
        "LLLL.LL.LL",
        "L.LL.LL.LL",
        "L.LLLLL.LL",
        "..L.L.....",
        "LLLLLLLLLL",
        "L.LLLLLL.L",
        "L.LLLLL.LL"
      ]

      assert 26 == Day11.task2(input)
    end
  end

  describe "&next_iteration/1" do
    test "given only an empty seat" do
      assert [["#"]] == Day11.next_iteration([["L"]])
    end

    test "given only floor" do
      assert [["."]] == Day11.next_iteration([["."]])
    end

    test "given only a taken seat" do
      assert [["#"]] == Day11.next_iteration([["#"]])
    end

    test "given taken and free seat" do
      assert [["L", "#"]] == Day11.next_iteration([["L", "#"]])
    end

    test "given only free seats" do
      assert [["#", "#"], ["#", "#"]] == Day11.next_iteration([["L", "L"], ["L", "L"]])
    end
  end

  describe "&pad_seats/1" do
    test "given one element" do
      input = [["L"]]

      expected = [
        ["L", "L", "L"],
        ["L", "L", "L"],
        ["L", "L", "L"]
      ]

      assert expected == Day11.pad_seats(input)
    end

    test "given a grid of elements" do
      input = [
        ["L", ".", "#"],
        [".", "#", "L"]
      ]

      expected = [
        ["L", "L", "L", "L", "L"],
        ["L", "L", ".", "#", "L"],
        ["L", ".", "#", "L", "L"],
        ["L", "L", "L", "L", "L"]
      ]

      assert expected == Day11.pad_seats(input)
    end
  end
end
