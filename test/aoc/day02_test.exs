defmodule Aoc.Day02Test do
  use ExUnit.Case

  describe "&count_validated_with/2" do
    test "given no passwords" do
      assert 0 == Aoc.Day02.count_validated_with([], fn _ -> true end)
    end

    test "given only not parsable passwords" do
      passwords = ["invalid", "also invalid", "12-30 C: abc"]

      assert 0 == Aoc.Day02.count_validated_with(passwords, fn _ -> true end)
    end

    test "given parsable passwords" do
      passwords = ["1-2 c: abc", "1-3 d: foo"]

      assert 2 == Aoc.Day02.count_validated_with(passwords, fn _ -> true end)
    end

    test "given one valid passwords" do
      passwords = ["1-2 c: abc", "1-3 d: foo"]
      validator = fn {_, password} -> password == "abc" end

      assert 1 == Aoc.Day02.count_validated_with(passwords, validator)
    end
  end

  describe "&parse_password_line/1" do
    test "'1-3 a: abcde'" do
      assert {:ok, {{1, 3, "a"}, "abcde"}} == Aoc.Day02.parse_password_line("1-3 a: abcde")
    end

    test "'1-3 b: cdefg'" do
      assert {:ok, {{1, 3, "b"}, "cdefg"}} == Aoc.Day02.parse_password_line("1-3 b: cdefg")
    end

    test "'2-9 c: ccccccccc'" do
      assert {:ok, {{2, 9, "c"}, "ccccccccc"}} ==
               Aoc.Day02.parse_password_line("2-9 c: ccccccccc")
    end

    test "'invalid'" do
      assert :error == Aoc.Day02.parse_password_line("invalid")
    end
  end

  describe "&is_valid1?/1" do
    test "valid password" do
      assert Aoc.Day02.is_valid1?({{1, 3, "a"}, "abcde"})
    end

    test "too few chars" do
      assert !Aoc.Day02.is_valid1?({{1, 3, "a"}, "cdefg"})
    end

    test "too many chars" do
      assert !Aoc.Day02.is_valid1?({{1, 3, "a"}, "aabbaa"})
    end
  end

  describe "&is_valid2?/1" do
    test "first position matches" do
      assert Aoc.Day02.is_valid2?({{1, 3, "a"}, "abcde"})
    end

    test "second position matches" do
      assert Aoc.Day02.is_valid2?({{3, 5, "a"}, "aabbaa"})
    end

    test "both positions match" do
      assert !Aoc.Day02.is_valid2?({{1, 3, "c"}, "cbcde"})
    end

    test "neither positions match" do
      assert !Aoc.Day02.is_valid2?({{2, 4, "c"}, "cbcde"})
    end
  end
end
