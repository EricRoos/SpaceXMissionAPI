defmodule SpacexMissionApi.FalconNineBuilder do
  defstruct [:core, :name]
  alias SpacexMissionApi.Booster
  alias SpacexMissionApi.Repo
  alias SpacexMissionApi.Vehicle
  
  def start do
    %SpacexMissionApi.FalconNineBuilder{}
  end

  def attach_core(builder, core_number) do
    %{builder | core: find_core_by_number(core_number)}
  end

  def with_name(builder, name) do
    %{builder | name: name}
  end

  def build(builder) do
    Repo.insert! %Vehicle{
      booster_one_id: builder.core.id,
      rocket_configuration: "FalconNine"
    }
  end

  defp find_core_by_number(core_number) do
    Repo.get_by(Booster, core_number: core_number)
  end
end
