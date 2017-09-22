defmodule SpacexMissionApi.LandingZoneTest do
  use SpacexMissionApi.ModelCase

  alias SpacexMissionApi.LandingZone

  @valid_attrs %{name: "some name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = LandingZone.changeset(%LandingZone{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = LandingZone.changeset(%LandingZone{}, @invalid_attrs)
    refute changeset.valid?
  end
end
