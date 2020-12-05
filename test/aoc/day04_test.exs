defmodule Aoc.Day04Test do
  use ExUnit.Case

  describe "&task1/1" do
    test "example" do
      input = [
        "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd",
        "byr:1937 iyr:2017 cid:147 hgt:183cm",
        "",
        "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884",
        "hcl:#cfa07d byr:1929",
        "",
        "hcl:#ae17e1 iyr:2013",
        "eyr:2024",
        "ecl:brn pid:760753108 byr:1931",
        "hgt:179cm",
        "",
        "hcl:#cfa07d eyr:2025 pid:166559648",
        "iyr:2011 ecl:brn hgt:59in"
      ]

      assert 2 == Aoc.Day04.task1(input)
    end
  end

  describe "&join_nonempty/1" do
    test "given only breaks it joins them" do
      input = ["a", "bc", "d"]

      assert ["a bc d"] == Aoc.Day04.join_nonempty(input)
    end

    test "given only longer breaks it doesn't join them" do
      input = ["a", "", "bc", "", "d"]

      assert ["a", "bc", "d"] == Aoc.Day04.join_nonempty(input)
    end

    test "given longer breaks it divides them correctly" do
      input = ["a", "", "", "b", "", "", "", "c"]

      assert ["a", "", "b", "", "", "c"] == Aoc.Day04.join_nonempty(input)
    end

    test "given short and long breaks join them correctly" do
      input = ["a", "bc", "", "d e", "fgh", "", "i"]

      assert ["a bc", "d e fgh", "i"] == Aoc.Day04.join_nonempty(input)
    end
  end

  describe "&extract_keys/1" do
    test "given one password it extracts keys" do
      input = "foo:bar  baz:abc lorem:ipsum"

      assert ["foo", "baz", "lorem"] == Aoc.Day04.extract_keys(input)
    end

    test "given a list of passwords it extracts lists of keys" do
      input = ["foo:bar  baz:abc lorem:ipsum", "a:b c:d"]

      assert [["foo", "baz", "lorem"], ["a", "c"]] == Aoc.Day04.extract_keys(input)
    end
  end

  describe "&contains_required_keys?/2" do
    test "given the same keys" do
      password_keys = ["a", "b", "c"]
      required_keys = ["a", "c", "b"]

      assert Aoc.Day04.contains_required_keys?(password_keys, required_keys)
    end

    test "not given required keys" do
      password_keys = ["a", "c"]
      required_keys = ["a", "b", "c"]

      assert !Aoc.Day04.contains_required_keys?(password_keys, required_keys)
    end

    test "given required and extra keys" do
      password_keys = ["a", "c", "b", "d"]
      required_keys = ["a", "b", "c"]

      assert Aoc.Day04.contains_required_keys?(password_keys, required_keys)
    end
  end
end
