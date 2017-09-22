defmodule SpacexMissionApi.LandingZone do
  use SpacexMissionApi.Web, :model

  schema "landing_zones" do
    field :name, :string

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
