defmodule HomeSecurity.Alarms.Alarm do
  def start_link(state) do
    Agent.start_link(fn -> state end, [])
  end

  @doc """
  Get the current state of an alarm.
  """
  def current_state(pid) do
    Agent.get(pid, &(&1))
  end
end
