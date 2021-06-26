defmodule Aoc.Day16 do
  @moduledoc false

  def task1(input) do
    {rules, _, tickets} = parse_input(input)

    rule_tests =
      rules
      |> Enum.map(fn {_, range1, range2} ->
        fn x -> Enum.member?(range1, x) or Enum.member?(range2, x) end
      end)

    tickets
    |> Enum.flat_map(&Function.identity/1)
    |> Enum.filter(&Enum.all?(rule_tests, fn test -> not test.(&1) end))
    |> Enum.sum()
  end

  def parse_input(input) do
    do_parse_rules(input, [])
  end

  defp do_parse_rules(["", _ | tail], acc) do
    do_parse_your_ticket(tail, Enum.reverse(acc))
  end

  defp do_parse_rules([rule | tail], acc) do
    rule_regex = ~r/^([a-z ]+): (\d+)-(\d+) or (\d+)-(\d+)$/
    [name | boundaries] = Regex.run(rule_regex, rule, capture: :all_but_first)
    [a, b, c, d] = Enum.map(boundaries, &String.to_integer/1)

    do_parse_rules(tail, [{name, a..b, c..d} | acc])
  end

  defp do_parse_your_ticket([ticket, _, _ | tail], rules) do
    do_parse_nearby_tickets(tail, {rules, parse_ticket(ticket), []})
  end

  defp do_parse_nearby_tickets([ticket | tail], {rules, your_ticket, tickets}) do
    do_parse_nearby_tickets(tail, {rules, your_ticket, [parse_ticket(ticket) | tickets]})
  end

  defp do_parse_nearby_tickets(_, {rules, your_ticket, tickets}) do
    {rules, your_ticket, Enum.reverse(tickets)}
  end

  defp parse_ticket(ticket) do
    ticket |> String.split(",") |> Enum.map(&String.to_integer/1)
  end
end
