defmodule SpacexMissionApi.Repo.Migrations.CreateMission do
  use Ecto.Migration

  def change do
    create table(:missions) do
      add :name, :string
      add :vehicle_id, references(:vehicles, on_delete: :nothing)
      add :landing_zone_id, references(:landing_zones, on_delete: :nothing)

      timestamps()
    end

    create index(:missions, [:vehicle_id])
    create index(:missions, [:landing_zone_id])
  end
end
