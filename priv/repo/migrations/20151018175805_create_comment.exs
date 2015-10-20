defmodule Slackernews.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :user_id, :integer
      add :post_id, :integer
      add :upvotes, :integer
      add :downvotes, :integer
      add :content, :string

      timestamps
    end

  end
end
