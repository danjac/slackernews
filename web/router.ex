defmodule Slackernews.Router do
  use Slackernews.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Slackernews.Plug.Authenticate
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Slackernews do
    pipe_through :browser # Use the default browser stack

    get "/", PostController, :index
    get "/delete/:id", PostController, :delete
    get "/submit", PostController, :new
    post "/submit", PostController, :create

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    get "/logout", SessionController, :delete

    get "/register", RegisterController, :new
    post "/register", RegisterController, :create

    resource "/comment", CommentController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Slackernews do
  #   pipe_through :api
  # end
end
