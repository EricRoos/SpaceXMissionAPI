defmodule SpacexMissionApi.VehicleView do
  use SpacexMissionApi.Web, :view
  alias SpacexMissionApi.Image
  def render("index.json", %{vehicles: vehicles}) do
    %{data: render_many(vehicles, SpacexMissionApi.VehicleView, "vehicle.json")}
  end

  def render("show.json", %{vehicle: vehicle}) do
    %{data: render_one(vehicle, SpacexMissionApi.VehicleView, "vehicle.json")}
  end

  def render("vehicle.json", %{vehicle: vehicle}) do
    if vehicle.rocket_configuration == "FalconNine" do
      %{
        name: vehicle.rocket_configuration,
        booster: render_one(vehicle.booster_one, SpacexMissionApi.BoosterView, "booster.json")
      }
    else
      %{}
    end
  end
end
