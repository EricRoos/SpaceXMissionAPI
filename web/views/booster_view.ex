defmodule SpacexMissionApi.BoosterView do
  use SpacexMissionApi.Web, :view

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
end
