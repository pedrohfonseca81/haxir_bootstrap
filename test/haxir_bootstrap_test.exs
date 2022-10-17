defmodule HaxirBootstrap do
  use ExUnit.Case
  doctest HaxirBootstrap

  test "greets the world" do
    assert HaxirBootstrap.hello() == :world
  end
end
