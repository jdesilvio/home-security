defmodule HomeSecurity.Alarms.Server do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    alarms = %{}
    refs   = %{}
    {:ok, {alarms, refs}}
  end
end
