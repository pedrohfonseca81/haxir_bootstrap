defmodule HaxirBootstrap.New do
  @root Path.expand("../..", __DIR__)

  @haxir_repo "https://github.com/ioolliver/haxir.git"
  @haxir_version "~> 0.1.0"

  @default [
    {:dir, "default/lib", "lib"},
    {:dir, "default/lib/default", "lib/default"},
    {:dir, "default/test", "test"},
    {:dir, "default/config", "config"},
    {:eex, "default/lib/default/application.ex", "lib/default/application.ex"},
    {:eex, "default/lib/default/consumer.ex", "lib/default/consumer.ex"},
    {:eex, "default/lib/default.ex", "lib/default.ex"},
    {:eex, "default/test/test_helper.exs", "test/test_helper.exs"},
    {:eex, "default/test/default_test.exs", "test/default_test.exs"},
    {:eex, "default/config/config.exs", "config/config.exs"},
    {:eex, "default/config/dev.exs", "config/dev.exs"},
    {:eex, "default/config/test.exs", "config/test.exs"},
    {:eex, "default/.formatter.exs", ".formatter.exs"},
    {:eex, "default/mix.exs", "mix.exs"},
    {:md, "default/README.md", "README.md"}
  ]

  def copy(target, binding \\ []) do
    if binding[:create_dir], do: File.mkdir_p!(target)

    for {format, path, new_path} <- @default do
      new_path_replaced = String.replace(new_path, "default", binding[:app_name])
      new_path = "#{target}/#{new_path_replaced}"

      Mix.shell().info("#{new_path} created succesfully.")

      case format do
        :dir ->
          File.mkdir_p!(new_path)

        _file ->
          file =
            render("#{Path.relative_to(@root, Path.expand(target))}/templates/#{path}", binding)

          File.write!(new_path, file)
      end
    end

    install? = Mix.shell().yes?("Are you want fetch dependencies?")

    if install? do
      install(target)
    end
  end

  defp render(path, binding) do
    case File.read(Path.expand(path)) do
      {:ok, content} ->
        app_name = Keyword.get(binding, :app_name)
        app_name_module = Macro.camelize(app_name)

        binding = [
          app_name: app_name,
          app_name_module: app_name_module,
          haxir_version: @haxir_version,
          haxir_repo: @haxir_repo
        ]

        EEx.eval_string(content, binding)

      {:error, :enoent} ->
        Mix.shell().error("#{path} was not found.")
    end
  end

  defp install(path) do
    File.cd!(path, fn ->
      Mix.shell().cmd("mix do deps.get, haxir.setup")
    end)
  end
end
