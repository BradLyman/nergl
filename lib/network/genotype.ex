defmodule Genotype do
  @moduledoc """
  This module provides methods for constructing a Genotype for a neural network.
  The Genotype is a datastructure which provides all of the information needed
  to construct the network.

  ## Examples

    iex> id = Genotype.unique_id "some_prefix"
    iex> Genotype.is_id? id
    true

    iex> Genotype.is_id? "this isn't an id"
    false

  """

  @id_pattern ~r/(\w+)-(-?)(\d+)/

  @doc """
  Generate a new unique id using 'name' as a prefix.
  """
  def unique_id(name) do
    "#{name}-#{Integer.to_string(System.unique_integer())}"
  end

  @doc """
  Check if the provided id matches the format used by this module.
  """
  def is_id?(id) do
    Regex.match?(@id_pattern, id)
  end
end
