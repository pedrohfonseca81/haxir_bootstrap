defmodule <%= app_name_module%>.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      <%= app_name_module%>.Consumer
    ]

    opts = [strategy: :one_for_one, name: <%= app_name_module%>.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
