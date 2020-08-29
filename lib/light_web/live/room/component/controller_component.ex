defmodule LightWeb.Room.Component.Controller do
  use Phoenix.LiveComponent

  def render(assigns) do
    Phoenix.View.render(LightWeb.RoomView, "_controller.html", assigns)
  end

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{room: room, id: id}, socket) do
    socket =
      socket
      |> assign(:room, room)
      |> assign(:id, id)

    {:ok, socket}
  end

  def handle_event(
        "switch",
        %{"switch" => "on"},
        %{assigns: %{room: %{name: name}}} = socket
      ) do
    set_room_brightness(name, 100)

    {:noreply, socket}
  end

  def handle_event(
        "switch",
        %{"switch" => "off"},
        %{assigns: %{room: %{name: name}}} = socket
      ) do
    set_room_brightness(name, 0)

    {:noreply, socket}
  end

  def handle_event(
        "dimmer",
        %{"dimmer" => "up"},
        %{assigns: %{room: %{brightness: brightness, name: name}}} = socket
      )
      when brightness < 100 do
    brightness = brightness + 10

    set_room_brightness(name, brightness)
    {:noreply, socket}
  end

  def handle_event(
        "dimmer",
        %{"dimmer" => "down"},
        %{assigns: %{room: %{brightness: brightness, name: name}}} = socket
      )
      when brightness > 0 do
    brightness = brightness - 10

    set_room_brightness(name, brightness)
    {:noreply, socket}
  end

  def handle_event(
        "hide_modal",
        _value,
        %{assigns: %{room: %{name: name}}} = socket
      ) do
    hide_modal(name)
    {:noreply, socket}
  end

  def handle_event(_event, _value, socket) do
    {:noreply, socket}
  end

  defp set_room_brightness(name, brightness) do
    send(
      self(),
      {__MODULE__, :set_brightness, %{room: name, brightness: brightness}}
    )
  end

  defp hide_modal(name) do
    send(
      self(),
      {__MODULE__, :hide_modal, %{room: name}}
    )
  end
end
