defmodule ExAequoFn.Types do
  @moduledoc ~S"""
  Types of this project
  """

  defmacro __using__(_opts) do
    quote do
      @type either_t(error_t, ok_t) :: {:ok, ok_t} | {:error, error_t}
      @type maybe(t) :: nil | t
      @type result_t(t) :: {:ok, t} | :error
      @type stream_t :: %Stream{}
      @type transformer_t :: (any() -> result_t(any()))
      @type transformers_t :: list(transformer_t())
    end
  end
end

# SPDX-License-Identifier: AGPL-3.0-or-later
