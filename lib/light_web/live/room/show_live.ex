defmodule LightWeb.Room.ShowLive do
  use LightWeb, :live_view

  def render(assigns) do
    Phoenix.View.render(LightWeb.RoomView, "show.html", assigns)
  end

  def mount(%{"room" => room}, _session, socket) do
    socket =
      socket
      |> assign(:room, room)
      |> assign(:brightness, 100)

    {:ok, socket}
  end

  def handle_event("switch", %{"switch" => "on"}, socket) do
    {:noreply, assign(socket, :brightness, 100)}
  end

  def handle_event("switch", %{"switch" => "off"}, socket) do
    {:noreply, assign(socket, :brightness, 0)}
  end

  def handle_event(
        "dimmer",
        %{"dimmer" => "up"},
        %{assigns: %{brightness: brightness}} = socket
      )
      when brightness < 100 do
    brightness = brightness + 10

    {:noreply, assign(socket, :brightness, brightness)}
  end

  def handle_event(
        "dimmer",
        %{"dimmer" => "down"},
        %{assigns: %{brightness: brightness}} = socket
      )
      when brightness > 0 do
    brightness = brightness - 10

    {:noreply, assign(socket, :brightness, brightness)}
  end

  def handle_event(_event, _value, socket) do
    {:noreply, socket}
  end
end
