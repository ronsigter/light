defmodule LightWeb.PageLive do
  use LightWeb, :live_view

  def render(assigns) do
    Phoenix.View.render(LightWeb.PageView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event(_event, _value, socket) do
    {:noreply, socket}
  end
end
