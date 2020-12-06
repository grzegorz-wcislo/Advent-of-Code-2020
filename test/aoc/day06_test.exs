defmodule Aoc.Day06Test do
  use ExUnit.Case

  describe "&task1/1" do
    test "example 1" do
      input = [
        "abc",
        "",
        "a",
        "b",
        "c",
        "",
        "ab",
        "ac",
        "",
        "a",
        "a",
        "a",
        "a",
        "",
        "b"
      ]

      assert 11 == Aoc.Day06.task1(input)
    end

    test "trivial case" do
      assert 0 == Aoc.Day06.task1([])
    end

    test "one group" do
      input = ["a", "bc", "ad"]

      assert 4 == Aoc.Day06.task1(input)
    end

    test "two groups" do
      input = ["a", "bc", "ad", "", "db", "bc"]

      assert 7 == Aoc.Day06.task1(input)
    end
  end

  describe "&task2/1" do
    test "example 1" do
      input = [
        "abc",
        "",
        "a",
        "b",
        "c",
        "",
        "ab",
        "ac",
        "",
        "a",
        "a",
        "a",
        "a",
        "",
        "b"
      ]

      assert 6 == Aoc.Day06.task2(input)
    end

    test "trivial case" do
      assert 0 == Aoc.Day06.task1([])
    end

    test "one group" do
      input = ["abc", "bcda", "cag"]

      assert 2 == Aoc.Day06.task2(input)
    end

    test "two groups" do
      input = ["abc", "bcda", "cag", "", "gad", "abc"]

      assert 3 == Aoc.Day06.task2(input)
    end
  end

  describe "&parse_groups/1" do
    test "given no lines" do
      input = []

      assert [] == Aoc.Day06.parse_groups(input)
    end

    test "given one line" do
      input = ["abc"]

      assert [["abc"]] == Aoc.Day06.parse_groups(input)
    end

    test "given multiple lines" do
      input = ["a", "bc", "d"]

      assert [["a", "bc", "d"]] == Aoc.Day06.parse_groups(input)
    end

    test "given multiple groups" do
      input = ["a", "bc", "d", "", "foo", "bar"]

      assert [["a", "bc", "d"], ["foo", "bar"]] == Aoc.Day06.parse_groups(input)
    end
  end
end
