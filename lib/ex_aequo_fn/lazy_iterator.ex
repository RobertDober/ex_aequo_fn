defmodule ExAequoFn.LazyIterator do
  @moduledoc ~S"""
  Implements a lazy wrapper around `Enumerable` and _enumerableable_ (sic)
  data.

  This lazy wrapper than offers an **external** iterator which is implemented
  with the `next` function
  
  """

  defstruct stream: nil, current_element: {:error, "Iterator not initialized"}

end
# SPDX-License-Identifier: AGPL-3.0-or-later
