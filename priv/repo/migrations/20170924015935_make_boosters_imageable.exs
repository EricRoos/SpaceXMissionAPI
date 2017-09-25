defmodule SpacexMissionApi.Repo.Migrations.MakeBoostersImageable do
  use Ecto.Migration

  def change do
    create table(:booster_images, primary_key: false) do
      add :booster_id, references(:boosters, on_delete: :delete_all)
      add :image_id, references(:images, on_delete: :delete_all)

    end

  end
end
