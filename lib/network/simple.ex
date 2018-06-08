require Logger

alias Network.Simple, as: Net

defmodule Network.Simple.Cortex do
  use GenServer

  @moduledoc """
  The Cortex is the controller for the network.
  It is responsible for synchronizing signals from sensors and waiting for
  responses from actuators.
  This Cortex implementation does not wait for actuator responses.
  """

  @doc """
  Start a Cortex instance.
  """
  def start_link do
    GenServer.start_link(__MODULE__, {})
  end

  @doc """
  The Cortex will sync the sensors which triggers the network to begin
  processing the sensor output.

  ## Examples

    iex> {:ok, cortex} = Network.Simple.Cortex.start_link
    iex> Network.Simple.Cortex.sense_think_act cortex
  """
  def sense_think_act(cortex) do
    GenServer.call(cortex, :sense_think_act)
  end

  # Callbacks

  @impl true
  def init(_) do
    {:ok, actuator} = Net.Actuator.start_link()
    {:ok, neuron} = Net.Neuron.start_link(actuator)
    {:ok, sensor} = Net.Sensor.start_link(neuron)

    {:ok, %{sensor: sensor, neuron: neuron, actuator: actuator}}
  end

  @impl true
  def handle_call(:sense_think_act, _from, state) do
    {:reply, Net.Sensor.sync(state.sensor), state}
  end
end

defmodule Network.Simple.Sensor do
  use GenServer

  @moduledoc """
  The Sensor is responsible for creating a vector input based on some state in
  the environment.
  This Sensor just generates a random vector each time it is sync'd.
  """

  @doc """
  Create a Sensor instance which signals the provided neuron.
  """
  def start_link(neuron) do
    GenServer.start_link(
      __MODULE__,
      neuron
    )
  end

  @doc """
  Trigger the sensor to send environmental information to the configured
  neuron.
  """
  def sync(sensor) do
    GenServer.call(sensor, :sync)
  end

  # Callbacks

  @impl true
  def init(neuron) do
    {:ok, neuron}
  end

  @impl true
  def handle_call(:sync, _from, neuron) do
    environment = [:rand.uniform(), :rand.uniform()]
    {:reply, Net.Neuron.sense(neuron, environment), neuron}
  end
end

defmodule Network.Simple.Actuator do
  use GenServer

  @moduledoc """
  The Actuator is responsible for using a signal input to act upon the
  environment.
  """

  @doc """
  Create an Actuator instance.
  """
  def start_link do
    GenServer.start_link(
      __MODULE__,
      {}
    )
  end

  @doc """
  Send a signal to the actuator.
  """
  def sense(actuator, signal) do
    GenServer.call(actuator, {:forward, signal})
  end

  # Callbacks

  @impl true
  def init(args) do
    {:ok, args}
  end

  @impl true
  def handle_call({:forward, output}, _from, state) do
    {:reply, output, state}
  end
end

defmodule Network.Simple.Neuron do
  use GenServer

  @moduledoc """
  The neuron is responsible for the actual 'thinking' in the neural network.
  """

  defmodule State do
    @enforce_keys [:actuator, :weights]
    defstruct [:actuator, :weights]

    def create(actuator, size) do
      weights = for _ <- 0..size, do: :rand.uniform()
      %State{weights: weights, actuator: actuator}
    end
  end

  def start_link(actuator) do
    GenServer.start_link(
      __MODULE__,
      State.create(actuator, 2)
    )
  end

  def sense(neuron, signal) when is_list(signal) do
    GenServer.call(neuron, {:sense, signal})
  end

  # Callbacks

  @impl true
  def init(args) do
    {:ok, args}
  end

  @impl true
  def handle_call({:sense, signal}, _from, state) do
    value =
      Linalg.dot(signal ++ [1.0], state.weights)
      |> :math.tanh()

    {:reply, Net.Actuator.sense(state.actuator, value), state}
  end
end
