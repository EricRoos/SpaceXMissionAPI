defmodule SpacexMissionApi.FalconHeavyBuilder do
  defstruct [:left_core, :right_core, :center_core, :name]
  alias SpacexMissionApi.Booster
  alias SpacexMissionApi.Repo
  alias SpacexMissionApi.Vehicle
  
  def start do
    %SpacexMissionApi.FalconHeavyBuilder{}
  end

  def attach_left_core(builder, core_number) do
    %{builder | left_core: find_core_by_number(core_number)}
  end

  def attach_right_core(builder, core_number) do
    %{builder | right_core: find_core_by_number(core_number)}
  end

  def attach_center_core(builder, core_number) do
    %{builder | center_core: find_core_by_number(core_number)}
  end

  def with_name(builder, name) do
    %{builder | name: name}
  end

  def build(builder) do
    Repo.insert! %Vehicle{
      booster_one_id: builder.left_core.id,
      booster_two_id: builder.right_core.id,
      rocket_configuration: "FalconHeavy"
    }
  end

  defp find_core_by_number(core_number) do
    Repo.get_by(Booster, core_number: core_number)
  end
end
