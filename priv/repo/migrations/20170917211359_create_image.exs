defmodule SpacexMissionApi.Repo.Migrations.CreateImage do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :imageable_type, :string
      add :imageable_id, :integer
      add :source, :string
      add :source_type, :string

      timestamps()
    end

    create index("images", ["imageable_type", "imageable_id"], name: "imageable_ref_index")
  end
end
