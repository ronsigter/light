defmodule LightWeb.Room.ShowLive do
  use LightWeb, :live_view

  def render(assigns) do
    Phoenix.View.render(LightWeb.RoomView, "show.html", assigns)
  end

  def mount(%{"room" => room}, _session, socket) do
    socket =
      socket
      |> assign(:room, room)

    {:ok, socket}
  end

  def handle_event(_event, _value, socket) do
    {:noreply, socket}
  end
end
