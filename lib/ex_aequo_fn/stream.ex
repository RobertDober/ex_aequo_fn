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
    _zipn(streams)
    |> Enum.to_list 
  end

  defp _zip_get_row(streams, treated, row)
  defp _zip_get_row([], treated, row) do
    row1 = row
    |> Enum.reverse 
    |> List.to_tuple
    {row1, Enum.reverse(treated)}
  end
  defp _zip_get_row([hs|ts], treated, row) do
    if Enum.empty?(hs) do
      if Enum.empty?(treated) do
        nil
      else
        _zip_get_row(ts, [hs|treated], [nil|row])
      end
    else
      {h, t} = next(hs)
      _zip_get_row(ts, [t|treated], [h|row])
    end
  end

  defp _zipn(streams) do
    Stream.unfold(streams, &_zip_get_row(&1, [], []))
  end
  # defp _zipn([], result) do
  #   Enum.reverse(result)
  # end
  # defp _zipn(streams, result) do
  #   case _zip_get_row(streams, [], []) do
  #     :stop -> Enum.reverse(result)
  #     {row, next_streams} -> _zipn(next_streams, [row|result])
  #   end
  # end
end

# SPDX-License-Identifier: AGPL-3.0-or-later
