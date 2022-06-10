defmodule Impression.Scene.Main do
  @vsn "1"
  use Scenic.Scene
  alias Scenic.Graph

  import Scenic.Primitives
  require Logger

  @initial_message "Impression"
  @graph Graph.build(fill: :black, font: :roboto, theme: :light)
         |> rectangle({600, 448}, fill: :white)
         |> text(@initial_message, font_size: 72, t: {100, 100})

  def init(_, _) do
    state = %{graph: @graph}
    Logger.info("Started :mainscene")

    Process.register(self(), :mainscene)
    {:ok, state, push: @graph}
  end

  def handle_info({:update, message}, state) do
    if message !== nil do
      graph =
        Graph.build(fill: :black, font: :roboto, theme: :light)
        |> rectangle({600, 448}, fill: :white)
        |> text(message, font_size: 72, t: {100, 100})

      {:noreply, %{state | graph: graph}, push: graph}
    else
      {:noreply, state}
    end
  end
end
