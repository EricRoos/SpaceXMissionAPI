defmodule SpacexMissionApi.MissionView do
  use SpacexMissionApi.Web, :view

  def render("index.json", %{missions: missions}) do
    %{data: render_many(missions, SpacexMissionApi.MissionView, "mission.json")}
  end

  def render("show.json", %{mission: mission}) do
    %{data: render_one(mission, SpacexMissionApi.MissionView, "mission.json")}
  end

  def render("mission.json", %{mission: mission}) do
    %{
      id: mission.slug,
      name: mission.name,
      vehicle: render_one(mission.vehicle, SpacexMissionApi.VehicleView, "vehicle.json")
    }
  end
end
