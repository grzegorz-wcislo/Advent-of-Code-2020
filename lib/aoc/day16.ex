defmodule Aoc.Day16 do
  @moduledoc false

  def task1(input) do
    {rules, _, tickets} = parse_input(input)

    tickets
    |> Enum.flat_map(&Function.identity/1)
    |> Enum.filter(fn value -> Enum.all?(rules, &(!value_valid?(value, &1))) end)
    |> Enum.sum()
  end

  def task2(input) do
    {rules, my_ticket, tickets} = parse_input(input)

    valid_tickets = Enum.filter(tickets, &ticket_valid?(&1, rules))

    field_order(valid_tickets, rules)
    |> Enum.zip(my_ticket)
    |> Enum.filter(fn {name, _} -> String.starts_with?(name, "departure") end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.product()
  end

  def parse_input(input) do
    do_parse_rules(input, [])
  end

  def field_order(tickets, rules) do
    columns = tickets |> Enum.zip() |> Enum.map(&Tuple.to_list/1)

    columns
    |> Enum.with_index()
    |> Enum.map(fn {column, index} ->
      fields = possible_fields(column, rules)
      {length(fields), index, fields}
    end)
    |> Enum.sort()
    |> Enum.reduce([[], []], fn {_, index, fields}, [indices, resolved_fields] ->
      [field] =
        MapSet.difference(MapSet.new(fields), MapSet.new(resolved_fields)) |> MapSet.to_list()

      [[index | indices], [field | resolved_fields]]
    end)
    |> Enum.zip()
    |> Enum.sort()
    |> Enum.map(&elem(&1, 1))
  end

  def possible_fields(values, rules) do
    rules
    |> Enum.filter(fn rule -> Enum.all?(values, &value_valid?(&1, rule)) end)
    |> Enum.map(&elem(&1, 0))
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

  defp value_valid?(value, {_, range1, range2}) do
    Enum.member?(range1, value) or Enum.member?(range2, value)
  end

  defp ticket_valid?(ticket, rules) do
    ticket
    |> Enum.all?(fn value ->
      Enum.any?(rules, &value_valid?(value, &1))
    end)
  end
end
