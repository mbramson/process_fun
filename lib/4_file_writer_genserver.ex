defmodule FileWriterGenServer do
  use GenServer

  # Client

  def start_link(filename \\ "output.txt") do
    initial_state = %{filename: filename}
    GenServer.start_link(__MODULE__, initial_state)
  end

  def write(pid, text) do
    GenServer.cast(pid, {:write, text})
  end

  # Server Callbacks

  def handle_cast({:write, text}, state) do
    %{filename: filename} = state
    absolute_filename = Path.absname(filename)
    File.write(absolute_filename, text, [:append])

    {:noreply, state}
  end
end

# TODO
#
# Give the Genserver a global name so that it is the only one
#   hint for me: name: OneTrueFileWriter in start_link
#
# Allow it to tell us its current state
#
# Add ability to change the filename
#
# Add ability to count number of times we write and a client method
# to return that
#
# What happens to the count when we kill the process?
#
# start vs start_link
#
# Check out
# https://hexdocs.pm/elixir/GenServer.html#module-debugging-with-the-sys-module
