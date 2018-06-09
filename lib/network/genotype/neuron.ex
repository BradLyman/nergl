defmodule Genotype.Neuron do
  @moduledoc """
  A sensor sends signals to it's connected neurons in response to the
  environment.

  ## Examples

    iex> alias Genotype.Neuron, as: Neuron
    iex> neuron = Neuron.new "cortex_id"
    iex> initial = neuron.id
    iex> neuron2 = Neuron.new "cortex_id"
    iex> Neuron.with_input neuron, "sensor_id", [0.5, 0.5]
    iex> Neuron.with_input neuron, neuron2.id, [0.5]
    iex> Neuron.with_output neuron, "actuator_id"
    iex> initial == neuron.id
    true

  """

  import Genotype
  alias Genotype.Neuron, as: Neuron

  @enforce [:id, :cortex, :operation, :input, :output]
  defstruct [:id, :cortex, :operation, :input, :output]

  @doc """
  Create a neuron which isn't aware of any other neurons/sensors.
  """
  def new(cortex, operation \\ :tanh)
      when is_binary(cortex) and is_atom(operation) do
    %Neuron{
      id: unique_id(:name),
      cortex: cortex,
      operation: operation,
      input: %{},
      output: []
    }
  end

  @doc """
  Add an input and a set of weights to this neuron.
  The 'weights' list should be the same length as the output from the 'input'
  node.
  """
  def with_input(
      %Neuron{input: input} = neuron,
      id,
      weights
    )
    when is_binary(id) and is_list(weights)
  do
    %Neuron{
      neuron | input: Map.put(input, id, weights)
    }
  end

  @doc """
  Add an output target. This neuron will send it's computed value to each
  output.
  """
  def with_output(
      %Neuron{output: output} = neuron,
      id
    )
    when is_binary(id)
  do
    %Neuron{
      neuron | output: [id] ++ output
    }
  end
end
