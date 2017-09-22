defmodule SpacexMissionApi.Repo.Migrations.CreateBooster do
  use Ecto.Migration

  def change do
    create table(:boosters) do
      add :core_number, :string
      add :status, :string
      add :version, :string

      timestamps()
    end
  end
end
