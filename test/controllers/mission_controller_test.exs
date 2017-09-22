defmodule SpacexMissionApi.MissionControllerTest do
  use SpacexMissionApi.ConnCase

  alias SpacexMissionApi.Mission
  @valid_attrs %{name: "some name"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, mission_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    mission = Repo.insert! %Mission{}
    conn = get conn, mission_path(conn, :show, mission)
    assert json_response(conn, 200)["data"] == %{"id" => mission.id,
      "name" => mission.name,
      "vehicle_id" => mission.vehicle_id,
      "landing_zone_id" => mission.landing_zone_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, mission_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, mission_path(conn, :create), mission: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Mission, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, mission_path(conn, :create), mission: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    mission = Repo.insert! %Mission{}
    conn = put conn, mission_path(conn, :update, mission), mission: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Mission, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    mission = Repo.insert! %Mission{}
    conn = put conn, mission_path(conn, :update, mission), mission: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    mission = Repo.insert! %Mission{}
    conn = delete conn, mission_path(conn, :delete, mission)
    assert response(conn, 204)
    refute Repo.get(Mission, mission.id)
  end
end
