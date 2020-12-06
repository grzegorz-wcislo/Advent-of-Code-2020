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
  end

  def equal_groups?(left, right) do
    length(left) == length(right) and
      Enum.zip(left, right)
      |> Enum.all?(fn {left, right} -> MapSet.equal?(left, right) end)
  end

  describe "&join_groups/2 using &MapSet.union/2" do
    test "given no lines" do
      input = []

      assert equal_groups?([], Aoc.Day06.join_groups(input, &MapSet.union/2))
    end

    test "given one line" do
      input = ["abc"]

      assert equal_groups?(
               [MapSet.new(["a", "b", "c"])],
               Aoc.Day06.join_groups(input, &MapSet.union/2)
             )
    end

    test "given multiple lines in one group" do
      input = ["ac", "dc", "g"]

      assert equal_groups?(
               [MapSet.new(["a", "c", "d", "g"])],
               Aoc.Day06.join_groups(input, &MapSet.union/2)
             )
    end

    test "given multiple groups" do
      input = ["ac", "dc", "", "ab", "g"]

      assert equal_groups?(
               [MapSet.new(["a", "c", "d"]), MapSet.new(["a", "b", "g"])],
               Aoc.Day06.join_groups(input, &MapSet.union/2)
             )
    end
  end

  describe "&join_groups/2 using &MapSet.intersection/2" do
    test "given no lines" do
      input = []

      assert equal_groups?([], Aoc.Day06.join_groups(input, &MapSet.intersection/2))
    end

    test "given one line" do
      input = ["abc"]

      assert equal_groups?(
               [MapSet.new(["a", "b", "c"])],
               Aoc.Day06.join_groups(input, &MapSet.intersection/2)
             )
    end

    test "given multiple lines in one group" do
      input = ["adc", "dc", "dg"]

      assert equal_groups?(
               [MapSet.new(["d"])],
               Aoc.Day06.join_groups(input, &MapSet.intersection/2)
             )
    end

    test "given multiple groups" do
      input = ["ac", "dc", "", "ab", "g"]

      assert equal_groups?(
               [MapSet.new(["c"]), MapSet.new()],
               Aoc.Day06.join_groups(input, &MapSet.intersection/2)
             )
    end
  end
end
