defmodule Genotype.Id do
  @moduledoc """
  This module provides methods for constructing IDs for genotype elements.

  ## Examples

    iex> id = Genotype.Id.unique "some_prefix"
    iex> Genotype.Id.is_id? id
    true

    iex> Genotype.Id.is_id? "this isn't an id"
    false
  """

  @id_pattern ~r/(\w+)-(-?)(\d+)/

  @doc """
  Generate a new unique id using 'name' as a prefix.
  """
  def unique(name) do
    "#{name}-#{Integer.to_string(System.unique_integer())}"
  end

  @doc """
  Check if the provided id matches the format used by this module.
  """
  def is_id?(id) do
    Regex.match?(@id_pattern, id)
  end
end
