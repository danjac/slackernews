defmodule Slackernews.RegisterController do
  use Slackernews.Web, :controller
  alias Slackernews.User

  plug :scrub_params, "user" when action in [:create]
  plug :action

  def new(conn, _) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    if changeset.valid? do
      user = Slackernews.Registration.create(changeset, Repo)
      conn
      |> put_flash(:info, "Welcome")
      |> redirect(to: "/")
    else
      conn
      |> put_flash(:info, "Sorry, some probs")
      |> render("new.html", changeset: changeset)
    end
  end

end
