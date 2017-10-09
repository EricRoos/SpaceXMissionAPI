defmodule SpacexMissionApi.BoosterView do
  use SpacexMissionApi.Web, :view
  import SpacexMissionApi.Router.Helpers

  def render("index.json", %{boosters: boosters}) do
    %{data: render_many(boosters, SpacexMissionApi.BoosterView, "booster.json")}
  end

  def render("show.json", %{booster: booster}) do
    %{data: render_one(booster, SpacexMissionApi.BoosterView, "booster.json")}
  end

  def render("booster.json", %{booster: booster}) do
    %{
      core_number: booster.core_number,
      status: booster.status,
      version: booster.version,
      images: render_many(booster.images, SpacexMissionApi.ImageView, "image.json")
    }
  end

  def render("booster_with_url.json", %{booster: booster}) do
    Map.put(render("booster.json", %{booster: booster}), :url, booster_path(SpacexMissionApi.Endpoint, :show, booster.id))
  end
end
