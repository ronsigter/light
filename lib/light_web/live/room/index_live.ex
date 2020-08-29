defmodule LightWeb.Room.IndexLive do
  use LightWeb, :live_view
  alias LightWeb.Room.Component.{Controller, Room}

  @rooms [
    %{id: 1, name: "Hallway", brightness: 0, show: false},
    %{id: 2, name: "Sala", brightness: 0, show: false},
    %{id: 3, name: "Bedroom 1", brightness: 0, show: false},
    %{id: 4, name: "Bedroom 2", brightness: 0, show: false},
    %{id: 5, name: "Kitchen", brightness: 0, show: false}
  ]

  def render(assigns) do
    Phoenix.View.render(LightWeb.RoomView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :rooms, @rooms)}
  end

  def handle_event(_event, _value, socket) do
    {:noreply, socket}
  end

  # Handles Controller Component event states
  def handle_info(
        {Controller, :set_brightness, %{room: selected_room, brightness: brightness}},
        %{assigns: %{rooms: rooms}} = socket
      ) do
    rooms = Enum.map(rooms, &set_room_brightness(&1, selected_room, brightness))

    {:noreply, assign(socket, :rooms, rooms)}
  end

  def handle_info(
        {Controller, :hide_modal, %{room: selected_room}},
        %{assigns: %{rooms: rooms}} = socket
      ) do
    rooms = Enum.map(rooms, &hide_modal(&1, selected_room))

    {:noreply, assign(socket, :rooms, rooms)}
  end

  # Handles Room Component event states
  def handle_info(
        {Room, :show_modal, %{room: selected_room}},
        %{assigns: %{rooms: rooms}} = socket
      ) do
    rooms = Enum.map(rooms, &show_modal(&1, selected_room))

    {:noreply, assign(socket, :rooms, rooms)}
  end

  def handle_info(_channel, socket) do
    {:noreply, socket}
  end

  # Private Helpers
  defp set_room_brightness(%{name: name} = room, selected_room, brightness)
       when name == selected_room,
       do: %{room | brightness: brightness}

  defp set_room_brightness(room, _selected_room, _brightness), do: room

  defp show_modal(%{name: name} = room, selected_room)
       when name == selected_room,
       do: %{room | show: true}

  defp show_modal(room, _selected_room), do: room

  defp hide_modal(%{name: name} = room, selected_room)
       when name == selected_room,
       do: %{room | show: false}

  defp hide_modal(room, _selected_room), do: room
end
