defmodule SpacexMissionApi.Mission do
  use SpacexMissionApi.Web, :model

  schema "missions" do
    field :name, :string
    belongs_to :vehicle, SpacexMissionApi.Vehicle, foreign_key: :vehicle_id
    belongs_to :landing_zone, SpacexMissionApi.LandingZone, foreign_key: :landing_zone_id

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
