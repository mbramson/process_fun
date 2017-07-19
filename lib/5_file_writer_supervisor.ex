defmodule FileWriterSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = [
      # Only works if FileWriterGenServer implements start_link!
      worker(FileWriterGenServer, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end

# Supervisor.count_children(pid)
#
# [{_, child_pid, _, _}] = Supervisor.which_children(pid)
#
# Process.stop(child_pid, :theres_been_a_fire)
#
# Supervisor.which_children(pid)
# 
