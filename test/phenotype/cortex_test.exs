defmodule Phenotype.CortexTest do
  use ExUnit.Case, async: true
  doctest Phenotype.Cortex

  alias Phenotype.Cortex, as: Cortex
  alias Phenotype.Id, as: Id

  test "start link" do
    _cortex = Cortex.start_link
  end

  test "set sensors" do
    {:ok, cortex} = Cortex.start_link
    Cortex.replace_sensors(
      cortex,
      [%Id{id: "s1", pid: self()}, %Id{id: "s2", pid: self()}]
    )
    Cortex.manual_sync cortex
    receive do
      {_, :sync} -> IO.puts 'sync'
      otherwise -> assert false, "got an unexpected message"
    end
    receive do
      {_, :sync} -> IO.puts 'sync'
      otherwise -> assert false, "got an unexpected message"
    end
  end

  test "set actuators" do
    {:ok, cortex} = Cortex.start_link
    Cortex.replace_actuators(
      cortex,
      [%Id{id: "a1", pid: self()}, %Id{id: "a2", pid: self()}]
    )
    Cortex.replace_sensors(cortex, [%Id{id: "s1", pid: self()}])


  end
end
