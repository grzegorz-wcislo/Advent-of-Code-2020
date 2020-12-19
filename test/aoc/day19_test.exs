defmodule Aoc.Day19Test do
  use ExUnit.Case

  alias Aoc.Day19

  describe "&task1/1" do
    test "example 1" do
      input = [
        "2 * 3 + (4 * 5)",
        "5 + (8 * 3 + 9 + 3 * 4 * 3)",
        "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))",
        "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"
      ]

      assert 26335 == Day19.task1(input)
    end
  end

  describe "&evalute/1" do
    test "single number" do
      assert 7 == Day19.evaluate("7")
    end

    test "simple expression" do
      expression = "1 + 2 * 3 + 4 * 5 + 6"

      assert 71 == Day19.evaluate(expression)
    end

    test "more complex expression" do
      expression = "1 + (2 * 3) + (4 * (5 + 6))"

      assert 51 == Day19.evaluate(expression)
    end
  end
end
