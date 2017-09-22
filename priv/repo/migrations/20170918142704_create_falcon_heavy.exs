defmodule SpacexMissionApi.Repo.Migrations.CreateFalconHeavy do
  use Ecto.Migration

  def change do
    create table(:falcon_heavies) do
      add :booster_one_id, references(:boosters, on_delete: :nothing)
      add :booster_two_id, references(:boosters, on_delete: :nothing)

      timestamps()
    end

  end
end
