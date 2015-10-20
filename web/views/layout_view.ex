defmodule Slackernews.LayoutView do
  use Slackernews.Web, :view

  def title do
    Slackernews.Endpoint.config(:app_name)
  end

  def active_class(conn, path) do
    current_path = Path.join(["/" | conn.path_info])
    if path == current_path do
      "active"
    else
      ""
    end
  end
end
