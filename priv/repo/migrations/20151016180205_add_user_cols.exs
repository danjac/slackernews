defmodule Slackernews.Repo.Migrations.AddUserCols do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :is_active, :boolean, default: true
      add :is_admin, :boolean, default: false
      add :karma, :integer, default: 0
    end
  end
end
