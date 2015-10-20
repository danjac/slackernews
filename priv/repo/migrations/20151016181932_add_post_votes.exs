defmodule Slackernews.Repo.Migrations.AddPostVotes do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :downvotes, :integer, default: 0
      add :upvotes, :integer, default: 0
    end
  end
end
