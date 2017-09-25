defmodule SpacexMissionApi.LandingZoneView do
  use SpacexMissionApi.Web, :view

  def render("index.json", %{landing_zones: landing_zones}) do
    %{data: render_many(landing_zones, SpacexMissionApi.LandingZoneView, "landing_zone.json")}
  end

  def render("show.json", %{landing_zone: landing_zone}) do
    %{data: render_one(landing_zone, SpacexMissionApi.LandingZoneView, "landing_zone.json")}
  end

  def render("landing_zone.json", %{landing_zone: landing_zone}) do
    %{id: landing_zone.id,
      name: landing_zone.name}
  end
end
