defmodule Slackernews.Comment do
  use Slackernews.Web, :model

  schema "comments" do
    field :user_id, :integer
    field :post_id, :integer
    field :content, :string
    field :upvotes, :integer, default: 0
    field :downvotes, :integer, default: 0

    timestamps
  end

  @required_fields ~w(content)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
