defmodule Slackernews.PostTest do
  use Slackernews.ModelCase

  alias Slackernews.Post

  @valid_attrs %{title: "some content", url: "some content", user_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "total score" do
    post = %Post{upvotes: 5, downvotes: 3}
    assert Post.total_score(post) == 2
  end
end
