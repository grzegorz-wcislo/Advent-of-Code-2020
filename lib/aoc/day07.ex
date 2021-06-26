defmodule Aoc.Day07 do
  @moduledoc false

  def task1(input) do
    input
    |> Enum.map(&parse_rule/1)
    |> build_containment_map()
    |> get_all_containing("shiny gold")
    |> MapSet.size()
  end

  def task2(input) do
    input
    |> Enum.map(&parse_rule/1)
    |> build_containing_map()
    |> count_contained_bags("shiny gold")
  end

  def parse_rule(rule) do
    color_name = "[[:lower:]]+ [[:lower:]]+"
    bag_count = "[[:digit:]]+"

    rules_pattern = Regex.compile!("(#{color_name}) bags contain (.*)\.$")
    bag_pattern = Regex.compile!("^(#{bag_count}) (#{color_name}) bags?$")

    [bag | contents] = Regex.run(rules_pattern, rule, capture: :all_but_first)

    bags =
      case contents do
        ["no other bags"] ->
          []

        [contents] ->
          contents
          |> String.split(", ")
          |> Enum.map(&Regex.run(bag_pattern, &1, capture: :all_but_first))
          |> Enum.map(fn [count, color] -> {color, String.to_integer(count)} end)
      end

    {bag, bags}
  end

  def build_containment_map(rules) do
    rules
    |> Enum.reduce(%{}, fn {containing_bag, contained_bags}, map ->
      contained_bags
      |> Enum.reduce(map, fn {contained_bag, _}, map ->
        Map.update(map, contained_bag, [containing_bag], fn other_bags ->
          [containing_bag | other_bags]
        end)
      end)
    end)
  end

  def get_all_containing(containment_map, bag) do
    do_get_all_containing(MapSet.new(), containment_map, bag)
  end

  defp do_get_all_containing(containing, containment_map, bag) do
    case Map.get(containment_map, bag) do
      nil ->
        containing

      bags ->
        new_bags = MapSet.difference(MapSet.new(bags), containing)

        new_bags
        |> Enum.reduce(MapSet.union(containing, new_bags), fn bag, containing ->
          do_get_all_containing(containing, containment_map, bag)
        end)
    end
  end

  def build_containing_map(rules) do
    Map.new(rules)
  end

  def count_contained_bags(containing_map, bag) do
    case Map.get(containing_map, bag) do
      nil ->
        0

      bags ->
        bags
        |> Enum.map(fn {bag, count} -> count * (1 + count_contained_bags(containing_map, bag)) end)
        |> Enum.sum()
    end
  end
end
