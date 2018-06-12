defmodule Pairlist do
  @moduledoc """
  Methods for manipulating consecutive pairs of elements in a standard list.
  e.g. Given a list of elements like [a, b, c, d] apply a function to {a, b},
  {b, c}, and {c, d}.
  """

  @doc """
  Apply a function to a sliding window of two elements in a list.
  Replacing all but the first element with the results.

  ## Example

    iex> list = [1]
    iex> Pairlist.map(list, fn a,b -> a+b end)
    [1]

    iex> list = [3, 5]
    iex> Pairlist.map(list, fn a, b -> a+b end)
    [3, 8]

    iex> list = [1, 2, 3, 4, 5]
    iex> Pairlist.map(list, fn a, b -> a+b end)
    [1, 3, 5, 7, 9]

  """
  def map([first | list], fun) when is_function(fun) do
    apply_fun = &(update(&1, &2, fun))
    reduced = Enum.reduce(list, %{ret: [], prev: first}, apply_fun)
    [first] ++ reduced.ret
  end

  defp update(current, %{ret: list, prev: prev}, fun) do
    %{
      ret: list ++ [fun.(prev, current)],
      prev: current
    }
  end
end
