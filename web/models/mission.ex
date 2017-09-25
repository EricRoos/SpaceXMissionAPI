defmodule SpacexMissionApi.Mission do
  use SpacexMissionApi.Web, :model

  schema "missions" do
    field :name, :string
    field :slug, :string
    belongs_to :vehicle, SpacexMissionApi.Vehicle, foreign_key: :vehicle_id
    belongs_to :landing_zone, SpacexMissionApi.LandingZone, foreign_key: :landing_zone_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    cs = struct
    |> cast(params, [:name])
    |> validate_required([:name])

    slug = String.replace(get_field(cs, :name), " ", "-")
    cs
    |> change(%{slug: slug})
  end
end
