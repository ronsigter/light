defmodule LightWeb.Room.IndexLive do
  use LightWeb, :live_view
  alias LightWeb.Room.Component.ModalController

  @rooms [
    %{id: 1, name: "Kitchen", brightness: 100},
    %{id: 2, name: "Sala", brightness: 100},
    %{id: 3, name: "Bedroom 1", brightness: 100},
    %{id: 4, name: "Bedroom 2", brightness: 100},
    %{id: 5, name: "Hallway", brightness: 100}
  ]

  def render(assigns) do
    Phoenix.View.render(LightWeb.RoomView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:rooms, @rooms)

    {:ok, socket}
  end

  def handle_event(_event, _value, socket) do
    {:noreply, socket}
  end

  def handle_info(
        {ModalController, :set_brightness,
         %{
           room: selected_room,
           brightness: brightness
         }},
        %{assigns: %{rooms: rooms}} = socket
      ) do
    rooms = Enum.map(rooms, &set_room_brightness(&1, selected_room, brightness))

    {:noreply, assign(socket, :rooms, rooms)}
  end

  defp set_room_brightness(%{name: name} = room, selected_room, brightness)
       when name == selected_room,
       do: %{room | brightness: brightness}

  defp set_room_brightness(room, _selected_room, _brightness), do: room
end
