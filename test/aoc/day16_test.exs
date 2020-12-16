defmodule Aoc.Day16Test do
  use ExUnit.Case

  alias Aoc.Day16

  describe "&task1/1" do
    test "example 1" do
      input = [
        "class: 1-3 or 5-7",
        "row: 6-11 or 33-44",
        "seat: 13-40 or 45-50",
        "",
        "your ticket:",
        "7,1,14",
        "",
        "nearby tickets:",
        "7,3,47",
        "40,4,50",
        "55,2,20",
        "38,6,12"
      ]

      assert 71 == Day16.task1(input)
    end
  end

  describe "&parse_input/1" do
    test "example 1" do
      input = [
        "class: 1-3 or 5-7",
        "row: 6-11 or 33-44",
        "seat: 13-40 or 45-50",
        "",
        "your ticket:",
        "7,1,14",
        "",
        "nearby tickets:",
        "7,3,47",
        "40,4,50",
        "55,2,20",
        "38,6,12"
      ]

      assert {rules, ticket, tickets} = Day16.parse_input(input)
      assert [{"class", 1..3, 5..7}, {"row", 6..11, 33..44}, {"seat", 13..40, 45..50}] == rules
      assert [7, 1, 14] == ticket
      assert [[7, 3, 47], [40, 4, 50], [55, 2, 20], [38, 6, 12]] == tickets
    end
  end
end
