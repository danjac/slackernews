defmodule Slackernews.CommentController do
  use Slackernews.Web, :controller

  alias Slackernews.Comment
  alias Slackernews.Post

  plug :scrub_params, "comment" when action in [:create, :update]

  def delete(conn, %{"id" => id}) do
    comment = Repo.get!(Comment, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    #|> redirect(to: comment_path(conn, :index))
  end
end
