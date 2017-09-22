defmodule SpacexMissionApi.FalconNineTest do
  use SpacexMissionApi.ModelCase

  alias SpacexMissionApi.FalconNine
  alias SpacexMissionApi.Repo
  alias SpacexMissionApi.Booster

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    booster_one = Repo.insert! %Booster{
      :core_number => "b1",
      :version => "v1.0",
      :status => "ready"
    }
    changeset = FalconNine.changeset(%FalconNine{booster_id: booster_one.id}, @valid_attrs)
    assert changeset.valid?
    {_, falcon_nine} = Repo.insert(changeset)
    falcon_nine = falcon_nine
                  |> Repo.preload(:booster)
    assert falcon_nine.booster.id == booster_one.id
  end

  test "changeset with invalid attributes" do
    changeset = FalconNine.changeset(%FalconNine{}, @invalid_attrs)
    refute changeset.valid?
  end
end
