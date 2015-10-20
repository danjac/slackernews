defmodule Slackernews.PageController do
  use Slackernews.Web, :controller

  alias Slackernews.Post

  def index(conn, _params) do
    posts = Repo.all(
      from p in Post, order_by: [desc: p.inserted_at]
    )
    render conn, "index.html", posts: posts
  end
end
