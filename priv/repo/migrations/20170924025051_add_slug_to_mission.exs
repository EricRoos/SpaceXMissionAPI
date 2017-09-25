defmodule SpacexMissionApi.Repo.Migrations.AddSlugToMission do
  use Ecto.Migration

  def change do
    alter table :missions do
      add :slug, :string
    end
    create index(:missions, [:slug])
  end
end
