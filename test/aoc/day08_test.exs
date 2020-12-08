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

  describe "&task2/1" do
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

      assert 8 == Day08.task2(input)
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

  describe "&nop_jmp_swapped_list/1" do
    test "given a single instruction" do
      assert [[{"nop", 3}], [{"jmp", 3}]] == Day08.nop_jmp_swapped_list([{"jmp", 3}])
      assert [[{"jmp", 7}], [{"nop", 7}]] == Day08.nop_jmp_swapped_list([{"nop", 7}])
      assert [[{"acc", 13}]] == Day08.nop_jmp_swapped_list([{"acc", 13}])
    end

    test "given single nop and jmp and one acc instruction" do
      assert [[{"nop", 3}, {"acc", 2}], [{"jmp", 3}, {"acc", 2}]] ==
               Day08.nop_jmp_swapped_list([{"jmp", 3}, {"acc", 2}])

      assert [[{"jmp", 7}, {"acc", 2}], [{"nop", 7}, {"acc", 2}]] ==
               Day08.nop_jmp_swapped_list([{"nop", 7}, {"acc", 2}])
    end

    test "given multiple nop and jmp instructions" do
      assert [
               [{"nop", 3}, {"acc", 2}, {"jmp", 5}],
               [{"jmp", 3}, {"acc", 2}, {"nop", 5}],
               [{"jmp", 3}, {"acc", 2}, {"jmp", 5}]
             ] == Day08.nop_jmp_swapped_list([{"jmp", 3}, {"acc", 2}, {"jmp", 5}])

      assert [
               [{"jmp", 7}, {"acc", 2}, {"jmp", 8}],
               [{"nop", 7}, {"acc", 2}, {"nop", 8}],
               [{"nop", 7}, {"acc", 2}, {"jmp", 8}]
             ] == Day08.nop_jmp_swapped_list([{"nop", 7}, {"acc", 2}, {"jmp", 8}])
    end
  end

  describe "&execute_program/1" do
    test "given a simple finishable program" do
      instructions = [{"acc", 3}, {"jmp", 2}, {"acc", 2}, {"acc", 6}]

      assert {:finished, 9} == Day08.execute_program(instructions)
    end

    test "given a simple loop program" do
      assert {:loop, 0} == Day08.execute_program([{"nop", 0}, {"jmp", -1}])
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

      assert {:loop, 7} == Day08.execute_program(instructions)
    end
  end

  describe "&find_not_looping_result/1" do
    test "given 1 instruction" do
      assert 0 == Day08.find_not_looping_result([{"jmp", 0}])
    end

    test "given 2 instructions" do
      assert 2 == Day08.find_not_looping_result([{"acc", 2}, {"jmp", 0}])
    end

    test "given a more complex program" do
      instructions = [
        {"nop", 2},
        {"jmp", 2},
        {"acc", 1},
        {"acc", 2},
        {"jmp", -1}
      ]

      assert 2 == Day08.find_not_looping_result(instructions)
    end
  end
end
