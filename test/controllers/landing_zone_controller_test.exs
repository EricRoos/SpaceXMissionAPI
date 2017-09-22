defmodule SpacexMissionApi.LandingZoneControllerTest do
  use SpacexMissionApi.ConnCase

  alias SpacexMissionApi.LandingZone
  alias SpacexMissionApi.Image
  @valid_attrs %{name: "some name"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, landing_zone_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    landing_zone = Repo.insert! %LandingZone{}
    Image.attach(landing_zone, "test.jpg")
    conn = get conn, landing_zone_path(conn, :show, landing_zone)
    assert json_response(conn, 200)["data"] == %{"id" => landing_zone.id,
      "name" => landing_zone.name,
      "images" => %{url: "test.jpg"}}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, landing_zone_path(conn, :show, -1)
    end
  end


  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, landing_zone_path(conn, :create), landing_zone: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end


  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    landing_zone = Repo.insert! %LandingZone{}
    conn = put conn, landing_zone_path(conn, :update, landing_zone), landing_zone: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    landing_zone = Repo.insert! %LandingZone{}
    conn = delete conn, landing_zone_path(conn, :delete, landing_zone)
    assert response(conn, 204)
    refute Repo.get(LandingZone, landing_zone.id)
  end
end
