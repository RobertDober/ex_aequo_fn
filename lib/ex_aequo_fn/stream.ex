defmodule ExAequoFn.Stream do

  use ExAequoFn.Types


  @doc ~S"""
  Advances and returns head

      iex(1)> enum = 1..3
      ...(1)> {1, s} = next(enum)
      ...(1)> s |> Enum.to_list 
      [2, 3]

  At the end we get nil

      
      iex(2)> {1, s} = next([1]) 
      ...(2)> next(s)
      nil
    
  """
  @spec next(Enumerable.t) :: {any(), Enumerable.t}
  def next(enum) do
    if Enum.empty?(enum) do
      nil
    else
      h = Enum.take(enum, 1) |> List.first
      t = Stream.drop(enum, 1)
      {h, t}
    end
  end

  def zipn(streams) do
    _zipn(streams, [], [])
  end
  def zipn(streams)
end

# SPDX-License-Identifier: AGPL-3.0-or-later
