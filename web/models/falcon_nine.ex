defmodule SpacexMissionApi.FalconNine do
  use SpacexMissionApi.Web, :model

  schema "falcon_nines" do
    belongs_to :booster, SpacexMissionApi.Booster, foreign_key: :booster_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([:booster_id])
  end
end
