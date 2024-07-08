defmodule ExAequoFn do
  @moduledoc ~S"""
  Functional helpers

  ### `const_fn` 

  A function that returns a const

  Ignoring up to 3 additional args, returning a const 

      iex(1)> const_fn(1).()
      1

      iex(2)> const_fn(2, 1)
      2

      iex(3)> const_fn(:a, 1, 2)
      :a

      iex(4)> const_fn(nil, 1, :a, [])
      nil

  ### `nil_fn`

  Short for `const_fn(nil, ...)`
      
      iex(5)> nil_fn()
      nil

      iex(6)> nil_fn(42)
      nil

      iex(7)> nil_fn({:a, :b}, "hello")
      nil

      iex(8)> nil_fn([], "hello", %{})
      nil

   ### `tagged_fn`
   
   A function that wraps the result of `const_fn` into a tagged tuple

      iex(9)> tagged_fn(:alpha).("beta")
      {:alpha, "beta"}

  """
  def const_fn(const), do: fn -> const end
  def const_fn(const, _), do: const
  def const_fn(const, _, _), do: const
  def const_fn(const, _, _, _), do: const

  def nil_fn, do: nil
  def nil_fn(_), do: nil
  def nil_fn(_, _), do: nil
  def nil_fn(_, _, _), do: nil

  def tagged_fn(tag) do
    fn x -> {tag, x} end
  end
end

# SPDX-License-Identifier: AGPL-3.0-or-later
