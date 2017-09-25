defmodule SpacexMissionApi.Booster do
  use SpacexMissionApi.Web, :model
  schema "boosters" do
    field :core_number, :string
    field :status, :string
    field :version, :string
    many_to_many :images, SpacexMissionApi.Image, join_through: "booster_images"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:core_number, :status, :version])
    |> validate_required([:core_number, :status, :version])
  end
end
