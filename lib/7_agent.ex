defmodule AnimalCatalog do
  def start_link do
    Agent.start_link(fn -> Map.new end, name: __MODULE__)
  end

  def know_about?(animal) do
    Agent.get(__MODULE__, fn animal_map ->
      animal in Map.keys(animal_map)
    end)
  end

  def description_of(animal) do
    Agent.get(__MODULE__, fn animal_map ->
      Map.fetch(animal_map, animal)
    end)
  end

  def add_description(animal, description) do
    Agent.update(__MODULE__, fn animal_map ->
      Map.put(animal_map, animal, description)
    end)
  end
end
