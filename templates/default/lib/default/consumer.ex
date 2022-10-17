defmodule <%= app_name_module%>.Consumer do
  use Haxir.Consumer

  def handle_event({:player_joined, player}, state) do
    Haxir.Api.send_message("Welcome, #{player.name}!")
    {:state, state}
  end

  def handle_event({:player_left, player}, state) do
    Haxir.Api.send_message("#{player.name} has left!")
    {:state, state}
  end

  def handle_event({:new_message, {player, message}}, state) do
    Haxir.Api.send_message("#{player.name}: #{message}")
    {:state, state}
  end

  def handle_event(_event, state) do
    {:state, state}
  end
end
