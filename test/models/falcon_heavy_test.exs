defmodule SpacexMissionApi.FalconHeavyTest do
  use SpacexMissionApi.ModelCase

  alias SpacexMissionApi.FalconHeavy
  alias SpacexMissionApi.Repo
  alias SpacexMissionApi.Booster

  @valid_attrs %{}
  @invalid_attrs %{booster_three_id: 1}

  test "changeset with valid attributes" do
     booster_one = Repo.insert! %Booster{
      :core_number => "b1",
      :version => "v1.0",
      :status => "ready"
    }

    booster_two = Repo.insert! %Booster{
      :core_number => "b2",
      :version => "v1.0",
      :status => "ready"
    }

    changeset = FalconHeavy.changeset(%FalconHeavy{:booster_one_id => booster_one.id, :booster_two_id => booster_two.id}, @valid_attrs)
    assert changeset.valid?
    {_, falcon_heavy} = Repo.insert(changeset)
    falcon_heavy = falcon_heavy
    |> Repo.preload(:booster_one)
    |> Repo.preload(:booster_two)
    assert falcon_heavy.booster_one.core_number == booster_one.core_number
    assert falcon_heavy.booster_two.core_number == booster_two.core_number
  end

  test "changeset with invalid attributes" do
    changeset = FalconHeavy.changeset(%FalconHeavy{}, @invalid_attrs)
    refute changeset.valid?
  end
end
