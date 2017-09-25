defmodule SpacexMissionApi.Image do
  use SpacexMissionApi.Web, :model
  alias SpacexMissionApi.Repo
  alias SpacexMissionApi.Booster

  schema "images" do
    field :imageable_id, :integer
    field :source, :string
    field :source_type, :string
    timestamps()
  end

  def attach(imageable, source) do
    table_name = table_name_for(imageable)
    #cs = Image.changeset(%Image{}, %{"imageable_type" => table_name, "imageable_id" => imageable.id, "source" => source, "source_type" => "url" })
    #Repo.insert(cs)
  end

  def find_for(imageables) when is_list(imageables) do
    images = Enum.group_by(imageables, fn a -> table_name_for(a) end)
    |> Enum.to_list
    |> Enum.map(fn i -> for_many(elem(i,0), elem(i,1)) end)
    |> List.flatten

    Enum.map(imageables, fn i -> %{i | images:  Enum.filter(images, fn image -> matches_imageable(image, i ) end)} end)

  end

  def find_for(imageable) do
    Enum.at(find_for([imageable]), 0)
  end
  
  defp matches_imageable(image, imageable) do
    image.imageable_id == imageable.id && image.imageable_type == table_name_for(imageable)
  end
  defp for_many(table_name, imageables) do
    imageable_ids = Enum.map(imageables, fn a -> a.id end)
    Repo.all(
      from i in Image,
        where: i.imageable_type == ^table_name,
        where: i.imageable_id in ^imageable_ids
    )
  end

  defp table_name_for(imageable) do
    {_, table_name} = imageable.__meta__.source
    table_name
  end


  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:imageable_type, :imageable_id, :source, :source_type])
    |> validate_required([:imageable_type, :imageable_id, :source, :source_type])
  end
end
