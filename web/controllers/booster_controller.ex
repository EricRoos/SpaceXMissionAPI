defmodule SpacexMissionApi.BoosterController do
  use SpacexMissionApi.Web, :controller

  alias SpacexMissionApi.Booster
  alias SpacexMissionApi.Image

  def index(conn, _params) do
    boosters = Repo.all(Booster)
    |> Image.find_for

    render(conn, "index.json", boosters: boosters)
  end

  def create(conn, %{"booster" => booster_params}) do
    changeset = Booster.changeset(%Booster{}, booster_params)

    case Repo.insert(changeset) do
      {:ok, booster} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", booster_path(conn, :show, booster))
        |> render("show.json", booster: booster)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SpacexMissionApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    booster = Repo.get!(Booster, id)
              |> Image.find_for
    render(conn, "show.json", booster: booster)
  end

  def update(conn, %{"id" => id, "booster" => booster_params}) do
    booster = Repo.get!(Booster, id)
    changeset = Booster.changeset(booster, booster_params)

    case Repo.update(changeset) do
      {:ok, booster} ->
        render(conn, "show.json", booster: booster)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SpacexMissionApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    booster = Repo.get!(Booster, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(booster)

    send_resp(conn, :no_content, "")
  end
end
