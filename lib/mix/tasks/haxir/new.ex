defmodule Mix.Tasks.Haxir.New do
  @name "Haxir Bootstrap"
  @version Mix.Project.config()[:version]

  def run([version]) when version in ~w{-v --version} do
    Mix.shell().info("#{@name} #{@version}")
  end

  def run(["."]) do
    path = File.cwd!()

    app_name = path |> String.split("/") |> List.last()

    HaxirBootstrap.New.copy(path, app_name: Macro.underscore(app_name) |> String.trim())
  end

  def run([name]) do
    path = "#{File.cwd!()}/#{name}"

    HaxirBootstrap.New.copy(path,
      app_name: Macro.underscore(name) |> String.trim(),
      create_dir: true
    )
  end
end
