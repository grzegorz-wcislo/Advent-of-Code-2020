defmodule Aoc.Day07Test do
  use ExUnit.Case

  describe "&task1/1" do
    test "example 1" do
      input = [
        "light red bags contain 1 bright white bag, 2 muted yellow bags.",
        "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
        "bright white bags contain 1 shiny gold bag.",
        "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
        "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
        "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
        "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
        "faded blue bags contain no other bags.",
        "dotted black bags contain no other bags."
      ]

      assert 4 == Aoc.Day07.task1(input)
    end
  end

  describe "&task2/1" do
    test "example 1" do
      input = [
        "light red bags contain 1 bright white bag, 2 muted yellow bags.",
        "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
        "bright white bags contain 1 shiny gold bag.",
        "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
        "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
        "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
        "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
        "faded blue bags contain no other bags.",
        "dotted black bags contain no other bags."
      ]

      assert 32 == Aoc.Day07.task2(input)
    end

    test "example 2" do
      input = [
        "shiny gold bags contain 2 dark red bags.",
        "dark red bags contain 2 dark orange bags.",
        "dark orange bags contain 2 dark yellow bags.",
        "dark yellow bags contain 2 dark green bags.",
        "dark green bags contain 2 dark blue bags.",
        "dark blue bags contain 2 dark violet bags.",
        "dark violet bags contain no other bags."
      ]

      assert 126 == Aoc.Day07.task2(input)
    end
  end

  describe "&parse_rule/1" do
    test "given an empty bag" do
      input = "dotted black bags contain no other bags."

      assert {"dotted black", []} == Aoc.Day07.parse_rule(input)
    end

    test "given a bag containing one other item" do
      input = "faded blue bags contain 1 shiny gold bag."

      assert {"faded blue", [{"shiny gold", 1}]} == Aoc.Day07.parse_rule(input)
    end

    test "given a bag containing two other item" do
      input = "vibrant blue bags contain 2 muted yellow bags, 6 dotted black bags."

      assert {"vibrant blue", [{"muted yellow", 2}, {"dotted black", 6}]} ==
               Aoc.Day07.parse_rule(input)
    end
  end

  describe "&build_containment_map/1" do
    test "given no rules" do
      assert %{} == Aoc.Day07.build_containment_map([])
    end

    test "given one rule with an empty bag" do
      rules = [{"faded blue", []}]

      assert %{} == Aoc.Day07.build_containment_map(rules)
    end

    test "given one rule with an one item bag" do
      rules = [{"faded blue", [{"muted yellow", 2}]}]

      assert %{"muted yellow" => ["faded blue"]} == Aoc.Day07.build_containment_map(rules)
    end

    test "given one rule with a multiple item bag" do
      rules = [{"vibrant blue", [{"muted green", 2}, {"dotted black", 4}]}]

      assert %{"muted green" => ["vibrant blue"], "dotted black" => ["vibrant blue"]} ==
               Aoc.Day07.build_containment_map(rules)
    end

    test "given multiple rules" do
      rules = [
        {"vibrant blue", [{"muted green", 2}, {"dotted black", 4}]},
        {"faded blue", [{"muted yellow", 2}, {"dotted black", 3}]},
        {"faded blue", []}
      ]

      assert %{
               "muted green" => ["vibrant blue"],
               "dotted black" => ["faded blue", "vibrant blue"],
               "muted yellow" => ["faded blue"]
             } ==
               Aoc.Day07.build_containment_map(rules)
    end
  end

  describe "&get_all_containing/2" do
    test "given an empty containment map" do
      assert MapSet.new() == Aoc.Day07.get_all_containing(%{}, "dotted blue")
    end

    test "given a straight containment map" do
      containment_map = %{"a" => ["b"], "b" => ["c"], "c" => ["d"]}

      assert MapSet.new(["b", "c", "d"]) == Aoc.Day07.get_all_containing(containment_map, "a")
      assert MapSet.new(["c", "d"]) == Aoc.Day07.get_all_containing(containment_map, "b")
      assert MapSet.new(["d"]) == Aoc.Day07.get_all_containing(containment_map, "c")
      assert MapSet.new() == Aoc.Day07.get_all_containing(containment_map, "d")
    end

    test "given a cycle" do
      containment_map = %{"a" => ["b"], "b" => ["c"], "c" => ["b"]}

      assert MapSet.new(["b", "c"]) == Aoc.Day07.get_all_containing(containment_map, "a")
      assert MapSet.new(["b", "c"]) == Aoc.Day07.get_all_containing(containment_map, "b")
      assert MapSet.new(["b", "c"]) == Aoc.Day07.get_all_containing(containment_map, "c")
    end

    test "given a tree" do
      containment_map = %{"a" => ["b"], "b" => ["c", "d"], "c" => ["e"]}

      assert MapSet.new(["b", "c", "d", "e"]) ==
               Aoc.Day07.get_all_containing(containment_map, "a")

      assert MapSet.new(["c", "d", "e"]) == Aoc.Day07.get_all_containing(containment_map, "b")

      assert MapSet.new(["e"]) == Aoc.Day07.get_all_containing(containment_map, "c")
    end
  end

  describe "&build_containing_map/1" do
    test "given no rules" do
      assert %{} == Aoc.Day07.build_containing_map([])
    end

    test "given one rule" do
      rules = [{"a", [{"b", 2}, {"c", 3}]}]

      assert %{"a" => [{"b", 2}, {"c", 3}]} == Aoc.Day07.build_containing_map(rules)
    end

    test "given multiple rule" do
      rules = [
        {"a", [{"b", 2}, {"c", 3}]},
        {"b", [{"c", 2}]},
        {"c", [{"d", 6}]}
      ]

      assert %{
               "a" => [{"b", 2}, {"c", 3}],
               "b" => [{"c", 2}],
               "c" => [{"d", 6}]
             } == Aoc.Day07.build_containing_map(rules)
    end
  end

  describe "&count_contained_bags/2" do
    test "given an empty containing map" do
      assert 0 == Aoc.Day07.count_contained_bags(%{}, "a")
    end

    test "given a flat containing map" do
      containing_map = %{"a" => [{"b", 2}, {"c", 3}]}

      assert 5 == Aoc.Day07.count_contained_bags(containing_map, "a")
      assert 0 == Aoc.Day07.count_contained_bags(containing_map, "b")
      assert 0 == Aoc.Day07.count_contained_bags(containing_map, "c")
    end

    test "given a deep containing map" do
      containing_map = %{
        "a" => [{"b", 2}, {"c", 3}],
        "b" => [{"c", 2}, {"d", 1}],
        "c" => [{"e", 5}]
      }

      assert 46 == Aoc.Day07.count_contained_bags(containing_map, "a")
      assert 13 == Aoc.Day07.count_contained_bags(containing_map, "b")
      assert 5 == Aoc.Day07.count_contained_bags(containing_map, "c")
    end
  end
end
