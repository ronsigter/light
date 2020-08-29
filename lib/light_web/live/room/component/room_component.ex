defmodule LightWeb.Room.Component.Room do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~L"""
    <div class="room">
      <p class="name">
        <a href="#"><%= @room.name %></a>
      </p>
      <div class="light-bulb">
        <div class="base"></div>
        <div class="light"></div>
      </div>
      <div class="door"></div>
    </div>
    """
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
end
