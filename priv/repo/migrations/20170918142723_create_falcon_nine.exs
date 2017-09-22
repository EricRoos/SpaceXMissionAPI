defmodule SpacexMissionApi.Repo.Migrations.CreateFalconNine do
  use Ecto.Migration

  def change do
    create table(:falcon_nines) do
      add :booster_id, references(:boosters, on_delete: :nothing)

      timestamps()
    end
  end
end
