defmodule SpacexMissionApi.LandingZoneController do
  use SpacexMissionApi.Web, :controller

  alias SpacexMissionApi.LandingZone
  alias SpacexMissionApi.Image

  def index(conn, _params) do
    landing_zones = Repo.all(LandingZone)
                    |> Image.find_for
    render(conn, "index.json", landing_zones: landing_zones)
  end

  def create(conn, %{"landing_zone" => landing_zone_params}) do
    changeset = LandingZone.changeset(%LandingZone{}, landing_zone_params)

    case Repo.insert(changeset) do
      {:ok, landing_zone} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", landing_zone_path(conn, :show, landing_zone))
        |> render("show.json", landing_zone: landing_zone)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SpacexMissionApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    landing_zone = Repo.get!(LandingZone, id)
      |> Image.find_for
    render(conn, "show.json", landing_zone: landing_zone)
  end

  def update(conn, %{"id" => id, "landing_zone" => landing_zone_params}) do
    landing_zone = Repo.get!(LandingZone, id)
    changeset = LandingZone.changeset(landing_zone, landing_zone_params)

    case Repo.update(changeset) do
      {:ok, landing_zone} ->
        render(conn, "show.json", landing_zone: landing_zone)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SpacexMissionApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    landing_zone = Repo.get!(LandingZone, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(landing_zone)

    send_resp(conn, :no_content, "")
  end
end
