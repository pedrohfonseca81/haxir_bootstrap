defmodule <%= app_name_module%> do
  use ExUnit.Case
  doctest <%= app_name_module%>

  test "greets the world" do
    assert <%= app_name_module%>.hello() == :world
  end
end
