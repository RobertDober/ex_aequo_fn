defmodule ExAequoFn.Transformer do
  use ExAequoFn.Types

  @moduledoc ~S"""

  Implements functional transformation helpers

  ### `many`

  `many` takes a list and a list of transsformers. A transformer is simply a function
  that returns either `{:ok, value}` or `:error`

  The list is traversed by calling all transformers on each element of the list until
  the first transformer returns an `{:ok, value}` tuple in which case the element is
  replaced by `value`. If a transformer returning an `:ok` value is found for **all**
  elements, then the tuple `{:ok, [transformed values,...]}` is returned, otherwise
  `:error` is returned

      iex(1)> ft = %{a: 1, b: 2}
      ...(1)> st = %{a: 2, x: 3}
      ...(1)> ff = &Map.fetch(ft, &1)
      ...(1)> sf = &Map.fetch(st, &1)
      ...(1)> assert many([:a, :x], [ff, sf]) == {:ok, [1, 3]}
      ...(1)> assert many([:a, :z], [ff, sf]) == :error

  """

  @spec many(list(), transformers_t()) :: result_t(list())
  def many(values, transformers), do: _many(values, transformers, transformers, [])

  @spec _many(list(), transformers_t(), transformers_t(), list()) :: result_t(list())
  defp _many(values, transformers, current, result)
  defp _many([], _, _, result), do: {:ok, Enum.reverse(result)}
  defp _many(_, _, [], _), do: :error

  defp _many([h | t] = values, original, [curr | rest], result) do
    case curr.(h) do
      {:ok, value} -> _many(t, original, original, [value | result])
      :error -> _many(values, original, rest, result)
      _ -> raise ArgumentError, "function #{curr} is not a transformer"
    end
  end
end

# SPDX-License-Identifier: AGPL-3.0-or-later
