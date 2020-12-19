defmodule Aoc.Day18Test do
  use ExUnit.Case

  alias Aoc.Day18

  describe "&task1/1" do
    test "example 1" do
      input = [
        "2 * 3 + (4 * 5)",
        "5 + (8 * 3 + 9 + 3 * 4 * 3)",
        "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))",
        "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"
      ]

      assert 26335 == Day18.task1(input)
    end
  end

  describe "&task2/1" do
    test "example 1" do
      input = [
        "2 * 3 + (4 * 5)",
        "5 + (8 * 3 + 9 + 3 * 4 * 3)",
        "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))",
        "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"
      ]

      assert 693_891 == Day18.task2(input)
    end
  end

  describe "&evalute/1" do
    test "single number" do
      assert 7 == Day18.evaluate("7")
    end

    test "simple expression" do
      expression = "1 + 2 * 3 + 4 * 5 + 6"

      assert 71 == Day18.evaluate(expression)
    end

    test "example 1" do
      expression = "1 + (2 * 3) + (4 * (5 + 6))"

      assert 51 == Day18.evaluate(expression)
    end
  end

  describe "&evaluate_advanced/1" do
    test "single number" do
      assert 13 == Day18.evaluate_advanced("13")
    end

    test "simple expression" do
      expression = "1 + 2 * 3 + 4 * 5 + 6"

      assert 231 == Day18.evaluate_advanced(expression)
    end

    test "example 1" do
      expression = "1 + (2 * 3) + (4 * (5 + 6))"

      assert 51 == Day18.evaluate_advanced(expression)
    end

    test "example 2" do
      expression = "2 * 3 + (4 * 5)"

      assert 46 == Day18.evaluate_advanced(expression)
    end

    test "example 3" do
      expression = "5 + (8 * 3 + 9 + 3 * 4 * 3)"

      assert 1445 == Day18.evaluate_advanced(expression)
    end

    test "example 4" do
      expression = "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))"

      assert 669_060 == Day18.evaluate_advanced(expression)
    end

    test "example 5" do
      expression = "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"

      assert 23340 == Day18.evaluate_advanced(expression)
    end
  end
end
