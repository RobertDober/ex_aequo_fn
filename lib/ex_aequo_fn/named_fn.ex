defmodule ExAequoFn.NamedFn do
  use ExAequoFn.Types

  @moduledoc ~S"""
  A function wrapper
  """
  defstruct fun: nil, name: "anon", arity: 1

  @type t :: %__MODULE__{fun: function_t(), name: binary(), arity: non_neg_integer()}


  @doc ~S"""
  Same as `call(..., [])`, basically extracting fun
  """
  @spec call(t()) :: any()
  def call(%__MODULE__{}=myself) do
    call(myself, [])
  end

  @doc ~S"""
  This can also curry into a function

        iex(1)> join3 = new(&Enum.join([&1, &2, &3], "-"), "joiner")
        ...(1)> join2 = call(join3, ~W[a])
        ...(1)> assert join2.(~W[b c]) == "a-b-c"

  But be careful with arg sizes

        iex(2)> adder = new(&(&1 + &2))
        ...(2)> assert_raise(ArgumentError, fn -> call(adder, [1, 2, 3]) end)

  """
  @spec call(t(), any()) :: any()
  def call(named_fn, value)
  def call(%__MODULE__{}=myself, value) when is_list(value) do
    _apply(myself, value)
  end
  def call(%__MODULE__{}=myself, value) do
    _apply(myself, [value])
  end

  @spec new(function_t(), binary?()) :: t()
  def new(fun, name \\ nil) do
    with {:arity, arity} <- Function.info(fun, :arity) do
      name = name || inspect(fun)
      %__MODULE__{fun: fun, arity: arity, name: name}
    end
  end

  @spec _apply(t(), list()) :: any()
  defp _apply(%__MODULE__{}=myself, values) do
    l = Enum.count(values)
    if l > myself.arity do
      raise ArgumentError, "#{myself.name} of arity #{myself.arity}, called with #{l} arguments!\n#{inspect(values)}"
    end
    if l == myself.arity do
      apply(myself.fun, values)
    else
      _curry(myself, values)
    end
  end

  @spec _curry(t(), list()) :: function_t()
  defp _curry(%__MODULE__{}=myself, values) do
    &_fun(myself.fun, values, &1)
  end

  @spec _fun(function_t(), list(), any()) :: any()
  defp _fun(fun, values, rest)
  defp _fun(fun, values, rest) when is_list(rest) do
      args = values ++ rest
      apply(fun, args)
  end
  defp _fun(fun, values, rest) do
      args = values ++ [rest]
      apply(fun, args)
  end
end
# SPDX-License-Identifier: AGPL-3.0-or-later
