defmodule SpacexMissionApi.MissionController do
  use SpacexMissionApi.Web, :controller

  alias SpacexMissionApi.Mission
  alias SpacexMissionApi.Image

  def index(conn, _params) do
    missions = Repo.all(
      from mission in Mission,
        left_join: vehicle in assoc(mission, :vehicle),
        left_join: booster_one in assoc(vehicle, :booster_one),
        preload: [vehicle: {vehicle, booster_one: booster_one}]
    )
    render(conn, "index.json", missions: missions)
  end

  def create(conn, %{"mission" => mission_params}) do
    changeset = Mission.changeset(%Mission{}, mission_params)

    case Repo.insert(changeset) do
      {:ok, mission} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", mission_path(conn, :show, mission))
        |> render("show.json", mission: mission)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SpacexMissionApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    mission = Repo.get!(Mission, id)
    render(conn, "show.json", mission: mission)
  end

  def update(conn, %{"id" => id, "mission" => mission_params}) do
    mission = Repo.get!(Mission, id)
    changeset = Mission.changeset(mission, mission_params)

    case Repo.update(changeset) do
      {:ok, mission} ->
        render(conn, "show.json", mission: mission)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SpacexMissionApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    mission = Repo.get!(Mission, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(mission)

    send_resp(conn, :no_content, "")
  end
end
