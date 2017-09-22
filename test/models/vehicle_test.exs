defmodule SpacexMissionApi.VehicleTest do
  use SpacexMissionApi.ModelCase

  alias SpacexMissionApi.Vehicle

  @valid_attrs %{name: "some name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Vehicle.changeset(%Vehicle{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Vehicle.changeset(%Vehicle{}, @invalid_attrs)
    refute changeset.valid?
  end
end
