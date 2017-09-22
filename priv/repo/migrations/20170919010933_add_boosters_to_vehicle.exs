defmodule SpacexMissionApi.Repo.Migrations.AddBoostersToVehicle do
  use Ecto.Migration

  def change do
    alter table(:vehicles) do
      add :booster_one_id, references(:boosters, on_delete: :nothing)
      add :booster_two_id, references(:boosters, on_delete: :nothing)
      add :rocket_configuration, :string
    end
  end

end
