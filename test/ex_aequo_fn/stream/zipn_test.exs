defmodule Test.ExAequoFn.Stream.ZipnTest do
  use ExUnit.Case 
  import ExAequoFn.Stream, only: [zipn: 1]

  describe "zipn" do
    test("zips enums") do
      assert zipn([[1, 2], [10, 20]]) == [{1, 10}, {2, 20}]
    end
    test "uses nil if necessary" do
      assert zipn([[1, 2], [3]]) == [{1, 3}, {2, nil}]
    end
    test "the first enum rules, which also allows to use endless streams" do
      assert zipn([[1], [2, 3], Stream.cycle([4])]) == [{1, 2, 4}]
    end
    test "streams" do
      
    end
  end
end
# SPDX-License-Identifier: AGPL-3.0-or-later
