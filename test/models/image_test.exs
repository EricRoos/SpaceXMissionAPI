defmodule SpacexMissionApi.ImageTest do
  use SpacexMissionApi.ModelCase

  alias SpacexMissionApi.Image
  alias SpacexMissionApi.Booster
  alias SpacexMissionApi.Repo

  @valid_attrs %{imageable_id: 42, imageable_type: "some imageable_type", source: "some source", source_type: "some source_type"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Image.changeset(%Image{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Image.changeset(%Image{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "fetches images for imageable" do
    cs = Booster.changeset(%Booster{}, %{"core_number" => "test", "status" => "expended", "version" => "v1.0"})
    {_, booster} = Repo.insert(cs)
    Image.attach(booster, "test.jpg")
    Image.attach(booster, "test2.jpg")
    imageables = Image.find_for([booster])
    {imageable, images} = Enum.at(imageables,0)
    assert imageable == booster
    assert Enum.at(images, 0).source == "test2.jpg"
    assert Enum.at(images, 1).source == "test.jpg"
  end
end
