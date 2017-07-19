defmodule SleepyLetterCounter do
  def wait_and_count(text) do
    sleep_time = Enum.random(1..10)
    IO.puts "Taking a #{sleep_time} second nap before counting letters of #{text}"
    Process.sleep(sleep_time * 1000)
    IO.puts "Counting letters of #{text}"
    String.length(text)
  end

  def demo do
    task = Task.async(fn -> wait_and_count("cats") end)
    IO.puts "About to wait for an answer"
    Task.await(task, 20000)
  end

  def demo_with_map do
    list_of_words = ["cat", "dog", "fish", "tree", "a very long binary"]

    list_of_words
    |> Enum.map(fn word -> Task.async(fn -> wait_and_count(word) end) end)
    |> Enum.map(fn task -> Task.await(task, 20000) end)
  end
end
