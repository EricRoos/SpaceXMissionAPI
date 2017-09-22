defmodule SpacexMissionApi.ImageView do
  use SpacexMissionApi.Web, :view

  def render("image.json", %{image: image}) do
    %{url: image.source}
  end
end
