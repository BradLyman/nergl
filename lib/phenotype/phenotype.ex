defmodule Phenotype do
  @moduledoc """
  """

  defmodule Id do
    @enforce [:id, :pid]
    defstruct [:id, :pid]
  end

  defmodule Message do
    def sync(process) do
      GenServer.cast process, :sync
    end
  end
end
