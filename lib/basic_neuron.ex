require Logger

defmodule Neuron do
  use GenServer

  def with_weights(weights, bias) when is_list(weights) do
    GenServer.start_link(__MODULE__, {weights, bias})
  end

  def spawn_link do
    with_weights(
      [:random.uniform(), :random.uniform()],
      :random.uniform()
    )
  end

  def sense(pid, signal) when is_list(signal) do
    GenServer.call(pid, {:sense, signal})
  end

  # Callbacks

  @impl true
  def init({weights, bias}) do
    Logger.info("neuron #{as_string(self())} <#{as_string(weights)}> + #{as_string(bias)}")
    {:ok, {weights, bias}}
  end

  @impl true
  def handle_call({:sense, signal}, _from, {weights, bias}) do
    Logger.info("signal #{as_string(self())} <#{as_string(signal)}>")
    value = (dot(signal, weights) + bias) |> :math.tanh()
    {:reply, value, {weights, bias}}
  end

  defp dot(a, b) when is_list(a) and is_list(b) and length(a) == length(b) do
    Enum.zip(a, b)
    |> Enum.map(fn {x, y} -> x * y end)
    |> Enum.reduce(0, fn v, acc -> v + acc end)
  end

  defp as_string(list) when is_list(list) do
    Enum.map(list, &as_string/1)
  end

  defp as_string(n) when is_number(n) do
    n
    |> Float.round(3)
    |> Float.to_string()
  end

  defp as_string(pid) when is_pid(pid) do
    Kernel.inspect(pid)
  end
end
