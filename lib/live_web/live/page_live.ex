defmodule LiveWeb.PageLive do
  use LiveWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, items: [1], next_id: 2)}
  end

  def handle_event("add_item", _params, socket) do
    items = socket.assigns.items ++ [socket.assigns.next_id]

    {:noreply, assign(socket,
      items: items,
      next_id: socket.assigns.next_id + 1
    )}
  end

  def handle_event("remove_item", params, socket) do
    items = List.delete(socket.assigns.items, String.to_integer(params["item"]))
    {:noreply, assign(socket, items: items)}
  end

  def render(assigns) do
    ~H"""
    <p class="text-zinc-500">
      Add some items, then try to remove them.
      Watch the item numbers act erratically.
      This happens because each item is in a <%= "<div>" %>
      with a non-unique ID.
    </p>

    <button class="mt-8 p-8 text-3xl border border-zinc-800 bg-zinc-100 rounded" phx-click="add_item">
      Add item
    </button>

    <div class="mt-8 space-y-2 text-xl">
      <%= for item <- @items do %>
        <div id="non-unique" class="bg-zinc-50 border border-zinc-200 p-4 flex justify-between shadow">
          <span>
            Item
            <span class="inline-block px-4 py-2 text-blue-800 bg-blue-100 rounded font-bold text-2xl">
              <%= item %>
            </span>
          </span>

          <button phx-click="remove_item" phx-value-item={item} class="px-3 rounded text-red-600 opacity-30 hover:opacity-100 active:bg-red-100">
            ❌ Remove
          </button>
        </div>
      <% end %>
    </div>
    """
  end
end
