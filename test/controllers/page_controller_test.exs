defmodule Slackernews.PageControllerTest do
  use Slackernews.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "SlackerNews"
  end
end
