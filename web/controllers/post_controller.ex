defmodule Slackernews.PostController do
  use Slackernews.Web, :controller

  alias Slackernews.Post

  plug Slackernews.Plug.Authorize when action in [:new, :create, :delete]
  plug :scrub_params, "post" when action in [:create]
  #plug :action

  def index(conn, _params) do
    posts = Repo.all(
      from p in Post, order_by: [desc: p.inserted_at]
    )
    render conn, "index.html", posts: posts
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get_by!(Post, id: id, user_id: conn.assigns.current_user.id)
    Repo.delete!(post)
    conn
    |> put_flash(:info, "Your link has been deleted")
    |> redirect(to: "/")
  end

  def new(conn,  _) do
    changeset = Post.changeset(%Post{})
    render conn, changeset: changeset
  end

  def create(conn,  %{"post" => post_params}) do
    changeset = Post.changeset(%Post{user_id: conn.assigns.current_user.id}, post_params)
    if changeset.valid? do
      Repo.insert(changeset)
      conn
      |> put_flash(:info, "Your link has been posted")
      |> redirect(to: "/")
    else
      conn
      |> put_flash(:info, "Sorry, some probs")
      |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    render(conn, "show.html", {post: post, comment_changeset: %Comment.changeset{}})
  end

  def create_comment(conn, %{"id" => id, "comment" => comment_params}) do

    post = Repo.get!(Post, id)
    changeset = Comment.changeset(%Comment{post_id: post.id, user_id: conn.assigns.current_user.id}, comment_params)

    case Repo.insert(changeset) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: comment_path(conn, :index))
      {:error, changeset} ->
        render(conn, "show.html", comment_changeset: changeset)
    end
  end


end
