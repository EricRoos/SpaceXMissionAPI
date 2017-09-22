defmodule SpacexMissionApi.BoosterTest do
  use SpacexMissionApi.ModelCase

  alias SpacexMissionApi.Booster

  @valid_attrs %{core_number: "some core_number", status: "some status", version: "some version"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Booster.changeset(%Booster{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Booster.changeset(%Booster{}, @invalid_attrs)
    refute changeset.valid?
  end
end
