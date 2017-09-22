defmodule SpacexMissionApi.Repo.Migrations.CreateLandingZone do
  use Ecto.Migration

  def change do
    create table(:landing_zones) do
      add :name, :string

      timestamps()
    end
  end
end
