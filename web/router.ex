defmodule SpacexMissionApi.Router do
  use SpacexMissionApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SpacexMissionApi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", SpacexMissionApi do
    pipe_through :api
    resources "/vehicles", VehicleController, except: [:new, :edit]
    resources "/boosters", BoosterController, except: [:new, :edit]
    resources "/landing_zones", LandingZoneController, except: [:new, :edit]
    resources "/missions", MissionController, except: [:new, :edit]

  end

  # Other scopes may use custom stacks.
  # scope "/api", SpacexMissionApi do
  #   pipe_through :api
  # end
end
