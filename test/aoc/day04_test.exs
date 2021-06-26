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

  describe "&task2/1" do
    test "example valid" do
      input = [
        "pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980",
        "hcl:#623a2f",
        "",
        "eyr:2029 ecl:blu cid:129 byr:1989",
        "iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm",
        "",
        "hcl:#888785",
        "hgt:164cm byr:2001 iyr:2015 cid:88",
        "pid:545766238 ecl:hzl",
        "eyr:2022",
        "",
        "iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719"
      ]

      assert 4 == Aoc.Day04.task2(input)
    end

    test "example invalid" do
      input = [
        "eyr:1972 cid:100",
        "hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926",
        "",
        "iyr:2019",
        "hcl:#602927 eyr:1967 hgt:170cm",
        "ecl:grn pid:012533040 byr:1946",
        "",
        "hcl:dab227 iyr:2012",
        "ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277",
        "",
        "hgt:59cm ecl:zzz",
        "eyr:2038 hcl:74454a iyr:2023",
        "pid:3556412378 byr:2007"
      ]

      assert 0 == Aoc.Day04.task2(input)
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

  describe "&extract_entries/1" do
    test "given one password it extracts keys" do
      input = "foo:bar  baz:abc lorem:ipsum"

      assert %{"foo" => "bar", "baz" => "abc", "lorem" => "ipsum"} ==
               Aoc.Day04.extract_entries(input)
    end

    test "given a list of passwords it extracts lists of keys" do
      input = ["foo:bar  baz:abc lorem:ipsum", "a:b c:d"]

      assert [%{"foo" => "bar", "baz" => "abc", "lorem" => "ipsum"}, %{"a" => "b", "c" => "d"}] ==
               Aoc.Day04.extract_entries(input)
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

      refute Aoc.Day04.contains_required_keys?(password_keys, required_keys)
    end

    test "given required and extra keys" do
      password_keys = ["a", "c", "b", "d"]
      required_keys = ["a", "b", "c"]

      assert Aoc.Day04.contains_required_keys?(password_keys, required_keys)
    end
  end

  describe "&contains_valid_values?/1" do
    test "validates 'byr' field" do
      assert Aoc.Day04.contains_valid_values?(%{"byr" => "1998"})
      assert Aoc.Day04.contains_valid_values?(%{"byr" => "1920"})
      assert Aoc.Day04.contains_valid_values?(%{"byr" => "2002"})

      refute Aoc.Day04.contains_valid_values?(%{"byr" => "1919"})
      refute Aoc.Day04.contains_valid_values?(%{"byr" => "2003"})
      refute Aoc.Day04.contains_valid_values?(%{"byr" => "1998a"})
      refute Aoc.Day04.contains_valid_values?(%{"byr" => "nineteen sixty five"})
    end

    test "validates 'iyr' field" do
      assert Aoc.Day04.contains_valid_values?(%{"iyr" => "2015"})
      assert Aoc.Day04.contains_valid_values?(%{"iyr" => "2010"})
      assert Aoc.Day04.contains_valid_values?(%{"iyr" => "2020"})

      refute Aoc.Day04.contains_valid_values?(%{"iyr" => "2009"})
      refute Aoc.Day04.contains_valid_values?(%{"iyr" => "2021"})
      refute Aoc.Day04.contains_valid_values?(%{"iyr" => "2015b"})
      refute Aoc.Day04.contains_valid_values?(%{"iyr" => "two thousand sixteen"})
    end

    test "validates 'eyr' field" do
      assert Aoc.Day04.contains_valid_values?(%{"eyr" => "2025"})
      assert Aoc.Day04.contains_valid_values?(%{"eyr" => "2020"})
      assert Aoc.Day04.contains_valid_values?(%{"eyr" => "2030"})

      refute Aoc.Day04.contains_valid_values?(%{"eyr" => "2019"})
      refute Aoc.Day04.contains_valid_values?(%{"eyr" => "2031"})
      refute Aoc.Day04.contains_valid_values?(%{"eyr" => "2025b"})
      refute Aoc.Day04.contains_valid_values?(%{"eyr" => "two thousand twenty six"})
    end

    test "validates 'hgt' field" do
      assert Aoc.Day04.contains_valid_values?(%{"hgt" => "160cm"})
      assert Aoc.Day04.contains_valid_values?(%{"hgt" => "150cm"})
      assert Aoc.Day04.contains_valid_values?(%{"hgt" => "193cm"})

      assert Aoc.Day04.contains_valid_values?(%{"hgt" => "65in"})
      assert Aoc.Day04.contains_valid_values?(%{"hgt" => "59in"})
      assert Aoc.Day04.contains_valid_values?(%{"hgt" => "76in"})

      refute Aoc.Day04.contains_valid_values?(%{"hgt" => "149cm"})
      refute Aoc.Day04.contains_valid_values?(%{"hgt" => "194cm"})

      refute Aoc.Day04.contains_valid_values?(%{"hgt" => "58in"})
      refute Aoc.Day04.contains_valid_values?(%{"hgt" => "77in"})

      refute Aoc.Day04.contains_valid_values?(%{"hgt" => "70 inches"})
      refute Aoc.Day04.contains_valid_values?(%{"hgt" => "seventy inches"})
      refute Aoc.Day04.contains_valid_values?(%{"hgt" => "60ft"})
      refute Aoc.Day04.contains_valid_values?(%{"hgt" => "150"})
    end

    test "validates 'hcl' field" do
      assert Aoc.Day04.contains_valid_values?(%{"hcl" => "#123abc"})
      assert Aoc.Day04.contains_valid_values?(%{"hcl" => "#000000"})
      assert Aoc.Day04.contains_valid_values?(%{"hcl" => "#ffffff"})

      refute Aoc.Day04.contains_valid_values?(%{"hcl" => "red"})
      refute Aoc.Day04.contains_valid_values?(%{"hcl" => "#fff"})
      refute Aoc.Day04.contains_valid_values?(%{"hcl" => "#fffffff"})
      refute Aoc.Day04.contains_valid_values?(%{"hcl" => "#bcdefg"})
      refute Aoc.Day04.contains_valid_values?(%{"hcl" => "abcdef"})
    end

    test "validates 'ecl' field" do
      assert Aoc.Day04.contains_valid_values?(%{"ecl" => "amb"})
      assert Aoc.Day04.contains_valid_values?(%{"ecl" => "blu"})
      assert Aoc.Day04.contains_valid_values?(%{"ecl" => "brn"})
      assert Aoc.Day04.contains_valid_values?(%{"ecl" => "gry"})
      assert Aoc.Day04.contains_valid_values?(%{"ecl" => "grn"})
      assert Aoc.Day04.contains_valid_values?(%{"ecl" => "hzl"})
      assert Aoc.Day04.contains_valid_values?(%{"ecl" => "oth"})

      refute Aoc.Day04.contains_valid_values?(%{"ecl" => "red"})
      refute Aoc.Day04.contains_valid_values?(%{"ecl" => "foo"})
      refute Aoc.Day04.contains_valid_values?(%{"ecl" => "black"})
      refute Aoc.Day04.contains_valid_values?(%{"ecl" => "blk"})
      refute Aoc.Day04.contains_valid_values?(%{"ecl" => "other"})
    end

    test "validates 'pid' field" do
      assert Aoc.Day04.contains_valid_values?(%{"pid" => "123456789"})
      assert Aoc.Day04.contains_valid_values?(%{"pid" => "000000000"})

      refute Aoc.Day04.contains_valid_values?(%{"pid" => "abcdefghij"})
      refute Aoc.Day04.contains_valid_values?(%{"pid" => "abcde"})
      refute Aoc.Day04.contains_valid_values?(%{"pid" => "654321"})
      refute Aoc.Day04.contains_valid_values?(%{"pid" => "0123456789"})
    end
  end
end
