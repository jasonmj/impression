defmodule Impression.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    if Mix.target() != :host, do: start_epmd()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Impression.Supervisor]

    children =
      [
        # Children for all targets
        # Starts a worker by calling: Impression.Worker.start_link(arg)
        # {Impression.Worker, arg},
        {Scenic, viewports: [Application.get_env(:impression, :viewport)]}
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: Impression.Worker.start_link(arg)
      # {Impression.Worker, arg},
    ]
  end

  def children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: Impression.Worker.start_link(arg)
      # {Impression.Worker, arg},
    ]
  end

  def target() do
    Application.get_env(:impression, :target)
  end

  defp start_epmd() do
    # Start epmd and app node with cookie from :mix_tasks_upload_hotswap
    Logger.info("Starting epmd")
    System.cmd("epmd", ["-daemon"])
    Node.start(:"app@nerves-impression.local")
    Application.get_env(:mix_tasks_upload_hotswap, :cookie) |> Node.set_cookie()
  end

  def restart() do
    if Process.whereis(Impression.Supervisor) |> is_pid(),
      do: Supervisor.stop(Impression.Supervisor)

    Impression.Application.start(:normal, [])
  end
end
