defmodule SpacexMissionApi.PageController do
  use SpacexMissionApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
