defmodule Linalg do
  def dot(x, y) when is_list(x) and is_list(y) and length(x) == length(y) do
    Enum.zip(x, y)
    |> Enum.map(fn {a, b} -> a * b end)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end

  def pretty(vec) when is_list(vec) do
    vec
    |> Enum.map(&Linalg.pretty/1)
    |> Enum.join(", ")
    |> (fn str -> "[" <> str <> "]" end).()
  end

  def pretty(num) when is_number(num) do
    Float.round(num, 3) |> Float.to_string()
  end
end
