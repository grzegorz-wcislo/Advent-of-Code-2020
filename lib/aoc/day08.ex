defmodule Aoc.Day08 do
  defmodule State do
    defstruct acc: 0, ip: 0, instructions: [], history: []
  end

  def task1(input) do
    input
    |> Enum.map(&parse_instruction/1)
    |> execute_program()
  end

  def parse_instruction(input) do
    instruction_regex = ~r/^([[:lower:]]{3}) ([+-][[:digit:]]+)$/

    [operation, argument] = Regex.run(instruction_regex, input, capture: :all_but_first)

    {operation, String.to_integer(argument)}
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

  defp do_execute_program(%State{acc: acc, ip: ip, history: history} = state) do
    if Enum.find(history, &(&1 == ip)) do
      acc
    else
      state |> execute_step() |> do_execute_program()
    end
  end
end
