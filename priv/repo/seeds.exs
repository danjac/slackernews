# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Slackernews.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Slackernews.Repo
alias Slackernews.User
alias Slackernews.Post

user = Repo.insert!(%User{name: "admin", email: "admin@slackernews.com", is_admin: true})
Repo.insert!(%Post{title: "Reddit", url: "https://reddit.com", user: user.id})
