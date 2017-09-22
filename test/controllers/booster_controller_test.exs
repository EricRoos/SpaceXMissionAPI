defmodule SpacexMissionApi.BoosterControllerTest do
  use SpacexMissionApi.ConnCase

  alias SpacexMissionApi.Booster
  alias SpacexMissionApi.Image
  @valid_attrs %{core_number: "some core_number", status: "some status", version: "some version"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, booster_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    booster = Repo.insert! %Booster{}
    Image.attach(booster, "test1.jpg")
    conn = get conn, booster_path(conn, :show, booster)
    assert json_response(conn, 200)["data"] == %{"id" => booster.id,
      "core_number" => booster.core_number,
      "status" => booster.status,
      "version" => booster.version,
      "images" => [%{"url" => "test1.jpg"}]
    }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, booster_path(conn, :show, -1)
    end
  end


  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, booster_path(conn, :create), booster: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end


  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    booster = Repo.insert! %Booster{}
    conn = put conn, booster_path(conn, :update, booster), booster: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    booster = Repo.insert! %Booster{}
    conn = delete conn, booster_path(conn, :delete, booster)
    assert response(conn, 204)
    refute Repo.get(Booster, booster.id)
  end
end
