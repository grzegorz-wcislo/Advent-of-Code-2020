defmodule Aoc.Day08Test do
  use ExUnit.Case

  alias Aoc.Day08
  alias Aoc.Day08.State

  describe "&task1/1" do
    test "example 1" do
      input = [
        "nop +0",
        "acc +1",
        "jmp +4",
        "acc +3",
        "jmp -3",
        "acc -99",
        "acc +1",
        "jmp -4",
        "acc +6"
      ]

      assert 5 == Day08.task1(input)
    end
  end

  describe "&parse_instruction/1" do
    test "parses instruction operation" do
      assert {"nop", _} = Day08.parse_instruction("nop +0")
      assert {"acc", _} = Day08.parse_instruction("acc +13")
      assert {"jmp", _} = Day08.parse_instruction("jmp -7")
    end

    test "parses instruction argument" do
      assert {_, 0} = Day08.parse_instruction("nop +0")
      assert {_, 13} = Day08.parse_instruction("acc +13")
      assert {_, -7} = Day08.parse_instruction("jmp -7")
    end
  end

  describe "&execute_step/1" do
    test "changes accumulator value" do
      %State{acc: 0} = Day08.execute_step(%State{acc: 0, instructions: [{"nop", 0}]})

      %State{acc: 7} = Day08.execute_step(%State{acc: 1, instructions: [{"acc", 6}]})

      %State{acc: -10} = Day08.execute_step(%State{acc: 3, instructions: [{"acc", -13}]})

      %State{acc: 5} = Day08.execute_step(%State{acc: 5, instructions: [{"jmp", 10}]})
    end

    test "changes instruction pointer value" do
      %State{ip: 1} = Day08.execute_step(%State{ip: 0, instructions: [{"nop", 0}]})

      %State{ip: 2} = Day08.execute_step(%State{ip: 1, instructions: [{}, {"nop", 0}]})

      %State{ip: 1} = Day08.execute_step(%State{ip: 0, instructions: [{"acc", 10}]})

      %State{ip: 2} = Day08.execute_step(%State{ip: 1, instructions: [{}, {"acc", 10}]})

      %State{ip: 10} = Day08.execute_step(%State{ip: 0, instructions: [{"jmp", 10}]})

      %State{ip: 0} = Day08.execute_step(%State{ip: 1, instructions: [{}, {"jmp", -1}]})

      %State{ip: -4} = Day08.execute_step(%State{ip: 2, instructions: [{}, {}, {"jmp", -6}]})
    end

    test "adds instruction pointer to history" do
      %State{history: [0]} = Day08.execute_step(%State{instructions: [{"nop", 0}]})

      %State{history: [1, 0]} =
        Day08.execute_step(%State{ip: 1, instructions: [{}, {"nop", 0}], history: [0]})

      %State{history: [1, 3]} =
        Day08.execute_step(%State{ip: 1, instructions: [{}, {"nop", 0}], history: [3]})
    end
  end

  describe "&execute_program/1" do
    test "given a very simple program" do
      assert 0 == Day08.execute_program([{"nop", 0}, {"jmp", -1}])
    end

    test "given a more complex simple program" do
      instructions = [
        {"nop", 0},
        {"acc", 3},
        {"jmp", 4},
        {"acc", 5},
        {"acc", 4},
        {"jmp", -1},
        {"jmp", -2}
      ]

      assert 7 == Day08.execute_program(instructions)
    end
  end
end
