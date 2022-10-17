defmodule <%= app_name_module%>.MixProject do
  use Mix.Project

  def project do
    [
      app: :<%= app_name%>,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {<%= app_name_module%>.Application, []}
    ]
  end

  defp deps do
    [
      {:haxir, "<%= haxir_version%>", git: "<%= haxir_repo%>"}
    ]
  end
end
