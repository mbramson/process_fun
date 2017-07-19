defmodule FileWriter do

  def write(filename) do
    receive do
      {sender_pid, :write, text} ->
        IO.puts "writing #{text} to #{filename}"
        # Determine the full filename
        absolute_filename = Path.absname(filename)
        # Append to the file the text
        File.write(absolute_filename, text, [:append])
        # Tell the calling process that we've written
        send(sender_pid, {:ok, text, filename})
      _ ->
        IO.puts "what even is this"
    end
    write(filename)
  end
end

# What if we want to change the filename while the process is running?
#
# Check out
#   Process.info(pid)
#
# Check out
#   :observer.start()
#
# What does Process.link(pid) do?
#   What happens when we kill the process in iex?
