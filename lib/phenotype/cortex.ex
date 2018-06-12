defmodule Phenotype.Cortex do
  @moduledoc """
  The Cortex is responsible for synchronizing signals within the network.
  """

  use GenServer

  defmodule State do
    @enforce [:sensor_ids, :actuator_ids]
    defstruct [:sensor_ids, :actuator_ids]

    def empty, do: %State{sensor_ids: [], actuator_ids: []}
  end

  def start_link do
    GenServer.start_link __MODULE__, State.empty
  end

  def replace_sensors(cortex, sensor_ids) when is_list(sensor_ids) do
    GenServer.call cortex, {:replace_sensors, sensor_ids}
  end

  def replace_actuators(cortex, actuator_ids) when is_list(actuator_ids) do
    GenServer.call cortex, {:replace_actuators, actuator_ids}
  end

  def manual_sync(cortex) do
    GenServer.cast cortex, :manual_sync
  end

  # Callbacks


  @impl true
  def init(state = %State{}) do
    {:ok, state}
  end

  @impl true
  def handle_cast(:manual_sync, state = %State{sensor_ids: sensor_ids}) do
    for %Phenotype.Id{pid: sensor} <- sensor_ids do
      Phenotype.Message.sync sensor
    end
    {:noreply, state}
  end

  @impl true
  def handle_call({:replace_sensors, sensor_ids}, _from, state) do
    {:reply, :ok, %State{state | sensor_ids: sensor_ids}}
  end

  @impl true
  def handle_call({:replace_actuators, actuator_ids}, _from, state) do
    {:reply, :ok, %State{state | actuator_ids: actuator_ids}}
  end
end
