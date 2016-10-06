defmodule HomeSecurity.Alarms.AlarmSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(HomeSecurity.Alarms.Alarm, [], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end

  def new_alarm(state) do
    Supervisor.start_child(HomeSecurity.Alarms.AlarmSupervisor, [state])
  end
end
