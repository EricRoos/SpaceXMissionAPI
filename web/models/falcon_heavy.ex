defmodule SpacexMissionApi.FalconHeavy do
  use SpacexMissionApi.Web, :model

  schema "falcon_heavies" do
    belongs_to :booster_one, SpacexMissionApi.Booster, foreign_key: :booster_one_id
    belongs_to :booster_two, SpacexMissionApi.Booster, foreign_key: :booster_two_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([:booster_one_id, :booster_two_id])
  end
end
