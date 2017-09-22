defmodule SpacexMissionApi.Vehicle do
  use SpacexMissionApi.Web, :model

  schema "vehicles" do
    field :name, :string
    field :rocket_configuration, :string
    belongs_to :booster_one, SpacexMissionApi.Booster, foreign_key: :booster_one_id
    belongs_to :booster_two, SpacexMissionApi.Booster, foreign_key: :booster_two_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
