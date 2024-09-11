defmodule ExAequoFn.StreamTest do
  use ExUnit.Case
  doctest ExAequoFn.Stream, import: true

  describe "zipn" do
    it("zips enums") do
      assert zipn([1, 2], [10, 20]) == [{1, 10}, {2, 20}]
    end
    it "uses nil if necessary" do
      assert zipn([1, 2], [3]) == [{1, 3}, {2, nil}]
    end
    it "the first enum rules, which also allows to use endless streams" do
      assert zipn([1], [2, 3], Stream.cycle([4])) == [{1, 2, 4}]
    end
  end
end

# SPDX-License-Identifier: AGPL-3.0-or-later
