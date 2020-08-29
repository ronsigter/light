defmodule LightWeb.Room.Component.Room do
  use Phoenix.LiveComponent

  def render(assigns) do
    Phoenix.View.render(LightWeb.RoomView, "_room.html", assigns)
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
        "show_modal",
        _value,
        %{assigns: %{room: %{name: name}}} = socket
      ) do
    show_modal(name)
    {:noreply, socket}
  end

  def handle_event(_event, _value, socket) do
    {:noreply, socket}
  end

  defp show_modal(name) do
    send(
      self(),
      {__MODULE__, :show_modal, %{room: name}}
    )
  end
end
