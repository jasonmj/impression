defmodule Impression.Scene.Main do
  @vsn "1"
  use Scenic.Scene
  alias Scenic.Graph

  import Scenic.Primitives
  require Logger

  @graph Graph.build(fill: :black, font: :roboto)
         |> rectangle({600, 64}, t: {0, 64}, fill: :white)
         |> rectangle({600, 64}, t: {0, 128}, fill: :green)
         |> rectangle({600, 64}, t: {0, 192}, fill: :blue)
         |> rectangle({600, 64}, t: {0, 256}, fill: :red)
         |> rectangle({600, 64}, t: {0, 320}, fill: :yellow)
         |> rectangle({600, 64}, t: {0, 384}, fill: :orange)
         |> text("Black", font_size: 36, t: {24, 38}, fill: :white)
         |> text("White", font_size: 36, t: {24, 102}, fill: :black)
         |> text("Green", font_size: 36, t: {24, 166}, fill: :white)
         |> text("Blue", font_size: 36, t: {24, 230}, fill: :white)
         |> text("Red", font_size: 36, t: {24, 294}, fill: :white)
         |> text("Yellow", font_size: 36, t: {24, 358}, fill: :black)
         |> text("Orange", font_size: 36, t: {24, 422}, fill: :white)

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
