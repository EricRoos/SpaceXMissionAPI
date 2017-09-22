defmodule SpacexMissionApi.Repo.Migrations.CreateVehicle do
  use Ecto.Migration

  def change do
    create table(:vehicles) do
      add :name, :string

      timestamps()
    end
  end
end
