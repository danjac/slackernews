defmodule Slackernews.SessionController do
  use Slackernews.Web, :controller
  alias Slackernews.User

  plug :scrub_params, "user" when action in [:create]

  def new(conn, _) do
    render conn, changeset: User.changeset(%User{})
  end

  def create(conn, %{"user" => user_params}) do
    user = if is_nil(user_params["email"]) do
      nil
    else
      Repo.get_by(User, email: user_params["email"], is_active: true)
    end

    user
    |> sign_in(user_params["password"], conn)

  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Bye!")
    |> redirect(to: "/")
  end

  defp sign_in(user, _password, conn) when is_nil(user) do
    conn
    |> put_flash(:error, "Sorry, invalid login")
    |> render "new.html", changeset: User.changeset(%User{})
  end

  defp sign_in(user, password, conn) when is_map(user) do
    cond do
      Comeonin.Bcrypt.checkpw(password, user.crypted_password) ->
        conn
        |> put_session(:current_user, user)
        |> put_flash(:success, "Welcome back")
        |> redirect(to: "/")
        true ->
          conn
          |> put_flash(:error, "Invalid login")
          |> render "new.html", changeset: User.changeset(%User{})

    end
  end
end

