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

  describe "&field_order/2" do
    test "example 1" do
      tickets = [
        [3, 9, 18],
        [15, 1, 5],
        [5, 14, 9]
      ]

      rules = [
        {"class", 0..1, 4..19},
        {"row", 0..5, 8..19},
        {"seat", 0..13, 16..19}
      ]

      assert ["row", "class", "seat"] == Day16.field_order(tickets, rules)
    end
  end

  describe "&possible_rules/2" do
    test "example 1" do
      rules = [
        {"class", 0..1, 4..19},
        {"row", 0..5, 8..19},
        {"seat", 0..13, 16..19}
      ]

      assert ["row"] == Day16.possible_fields([3, 15, 5, 11], rules)
      assert ["class", "row"] == Day16.possible_fields([9, 1, 14, 12], rules)
      assert ["class", "row", "seat"] == Day16.possible_fields([8, 5, 9, 13], rules)
    end
  end
end
