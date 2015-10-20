defmodule Slackernews.Post do
  use Slackernews.Web, :model

  schema "posts" do
    field :title, :string
    field :url, :string
    field :description, :string
    field :downvotes, :integer, default: 0
    field :upvotes, :integer, default: 0
    belongs_to :user, Slackernews.User
    timestamps
  end

  @required_fields ~w(title url)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def total_score(model) do
    model.upvotes - model.downvotes
  end

  def can_delete_post?(user, post) do
    not is_nil(user) and user.id == post.user_id
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
