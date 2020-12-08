defmodule Aoc.Day08 do
  defmodule State do
    defstruct acc: 0, ip: 0, instructions: [], history: []
  end

  def task1(input) do
    input
    |> Enum.map(&parse_instruction/1)
    |> execute_program()
    |> elem(1)
  end

  def task2(input) do
    input
    |> Enum.map(&parse_instruction/1)
    |> find_not_looping_result()
  end

  def parse_instruction(input) do
    instruction_regex = ~r/^([[:lower:]]{3}) ([+-][[:digit:]]+)$/

    [operation, argument] = Regex.run(instruction_regex, input, capture: :all_but_first)

    {operation, String.to_integer(argument)}
  end

  def nop_jmp_swapped_list(instructions) do
    do_swap_nop_jmp(instructions)
  end

  defp do_swap_nop_jmp([]), do: [[]]

  defp do_swap_nop_jmp([{"acc", _} = first | other]) do
    other
    |> do_swap_nop_jmp()
    |> Enum.map(&[first | &1])
  end

  defp do_swap_nop_jmp([first | other]) do
    swapped_first =
      case first do
        {"nop", a} -> {"jmp", a}
        {"jmp", a} -> {"nop", a}
      end

    swapped_instructions = [swapped_first | other]

    unswapped_first_instructions =
      other
      |> do_swap_nop_jmp()
      |> Enum.map(&[first | &1])

    [swapped_instructions | unswapped_first_instructions]
  end

  def execute_step(%State{acc: acc, ip: ip, instructions: instructions, history: history}) do
    instruction = Enum.at(instructions, ip, {"nop", 0})

    history = [ip | history]

    acc =
      case instruction do
        {"acc", value} -> acc + value
        _ -> acc
      end

    ip =
      case instruction do
        {"jmp", value} -> ip + value
        _ -> ip + 1
      end

    %State{acc: acc, ip: ip, instructions: instructions, history: history}
  end

  def execute_program(instructions) do
    %State{instructions: instructions}
    |> do_execute_program()
  end

  defp do_execute_program(
         %State{acc: acc, ip: ip, instructions: instructions, history: history} = state
       ) do
    cond do
      Enum.find(history, &(&1 == ip)) -> {:loop, acc}
      ip >= length(instructions) -> {:finished, acc}
      true -> state |> execute_step() |> do_execute_program()
    end
  end

  def find_not_looping_result(instructions) do
    nop_jmp_swapped_list(instructions)
    |> Enum.map(&execute_program/1)
    |> Enum.find_value(fn
      {:loop, _} -> false
      {:finished, result} -> result
    end)
  end
end
