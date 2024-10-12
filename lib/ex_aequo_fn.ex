defmodule ExAequoFn do
  alias __MODULE__.{NamedFn, Transformer}
  use __MODULE__.Types

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

  ### `named_fn`

  By default they have arity 1

      iex(5)> add1 = named_fn(&(&1+1), "add1")
      ...(5)> assert add1.name == "add1"
      ...(5)> assert NamedFn.call(add1, 41) == 42
      ...(5)> assert NamedFn.call(add1, [41]) == 42

  They can be curried, (but that might not be very useful with arity 1)

      iex(6)> add1 = named_fn(&(&1+1), "add_one")
      ...(6)> assert is_function(NamedFn.call(add1))
      ...(6)> assert is_function(NamedFn.call(add1, []))
      ...(6)> NamedFn.call(add1).(72)
      73

  But more useful with higher arities

      iex(7)> adder = named_fn(&(&1+&2), "adder")
      ...(7)> assert is_function(NamedFn.call(adder))
      ...(7)> add42 = NamedFn.call(adder, 42)
      ...(7)> add42.(31)
      73

  More examples can be found in the doctests of `NamedFn`

  ### `nil_fn`

  Short for `const_fn(nil, ...)`

      iex(8)> nil_fn()
      nil

      iex(9)> nil_fn(42)
      nil

      iex(10)> nil_fn({:a, :b}, "hello")
      nil

      iex(11)> nil_fn([], "hello", %{})
      nil

   ### `tagged_fn`

   A function that wraps the result of `const_fn` into a tagged tuple

      iex(12)> tagged_fn(:alpha).("beta")
      {:alpha, "beta"}

   ### `transform_many`

   delegates to `ExAequoFn.Transformer.many` (see below for details)

  """

  @spec const_fn(a) :: a when a: any()
  def const_fn(const), do: fn -> const end
  @spec const_fn(a, any()) :: a when a: any()
  def const_fn(const, _), do: const
  @spec const_fn(a, any(), any()) :: a when a: any()
  def const_fn(const, _, _), do: const
  @spec const_fn(a, any(), any(), any()) :: a when a: any()
  def const_fn(const, _, _, _), do: const

  @spec named_fn(function_t(), binary?()) :: NamedFn.t()
  defdelegate named_fn(fun, name \\ nil), to: NamedFn, as: :new
    
  @spec nil_fn() :: nil
  def nil_fn, do: nil
  @spec nil_fn(any()) :: nil
  def nil_fn(_), do: nil
  @spec nil_fn(any(), any()) :: nil
  def nil_fn(_, _), do: nil
  @spec nil_fn(any(), any(), any()) :: nil
  def nil_fn(_, _, _), do: nil

  @spec tagged_fn(a) :: (b -> {a, b}) when a: any(), b: any()
  def tagged_fn(tag) do
    fn x -> {tag, x} end
  end

  defdelegate transform_many(input, transformations), to: Transformer, as: :many
end

# SPDX-License-Identifier: AGPL-3.0-or-later
