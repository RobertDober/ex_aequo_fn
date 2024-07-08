defmodule ExAequoFn do
  # use ExAequoFn.Types

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

  defdelegate transform_many(input, transformations), to: __MODULE__.Transformer, as: :many
end

# SPDX-License-Identifier: AGPL-3.0-or-later
