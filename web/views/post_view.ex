defmodule Slackernews.PostView do
  use Slackernews.Web, :view
  alias Slackernews.Post

  def total_score(post) do
    Post.total_score(post)
  end

  def can_delete_post?(conn, post) do
    Post.can_delete_post?(conn.assigns.current_user, post)
  end
end
