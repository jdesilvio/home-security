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

  @doc """
  Add a new alarm.
  """
  def add(name, state) when is_binary(name) and is_atom(state) do
    GenServer.cast(__MODULE__, {:add, name, state})
  end

  # Server

  def handle_cast({:add, name, state}, {alarms, refs}) do
    {:ok, pid} = HomeSecurity.Alarms.AlarmSupervisor.new_alarm(state)
    ref = Process.monitor(pid)
    id = auto_increment(alarms)
    refs = Map.put(refs, ref, id)
    alarms = Map.put(alarms, id, {name, pid, ref})
    {:noreply, {alarms, refs}}
  end

  # Helper to add unique IDs to alarms
  defp auto_increment(map) when map == %{}, do: 1
  defp auto_increment(alarms) do
    Map.keys(alarms)
      |> List.last
      |> Kernel.+(1)
  end
end
