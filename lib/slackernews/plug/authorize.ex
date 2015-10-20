defmodule Slackernews.Plug.Authorize do
  import Plug.Conn
  import Slackernews.Router.Helpers
  import Phoenix.Controller

  def init(default), do: default

  def call(conn, default) do
    if is_nil(conn.assigns.current_user) do
      redirect(conn, to: session_path(conn, :new))
    end
    conn
  end
end
