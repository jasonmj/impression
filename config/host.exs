import Config

config :impression, :viewport, %{
  name: :main_viewport,
  default_scene: {Impression.Scene.Main, nil},
  size: {600, 448},
  opts: [scale: 1.0],
  drivers: [
    %{
      module: Scenic.Driver.Glfw,
      name: :glfw,
      opts: [resizeable: false, title: "Example Application"]
    }
  ]
}

# Add configuration that is only needed when running on the host here.
