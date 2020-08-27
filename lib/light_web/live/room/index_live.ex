defmodule LightWeb.Room.IndexLive do
  use LightWeb, :live_view

  def render(assigns) do
    Phoenix.View.render(LightWeb.RoomView, "index.html", assigns)
  end

  def mount(params, session, socket) do
    {:ok, socket}
  end

  def handle_event(_event, _value, socket) do
    {:noreply, socket}
  end
end
