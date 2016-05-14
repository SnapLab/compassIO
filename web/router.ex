defmodule CompassIO.Router do
  use CompassIO.Web, :router

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

  scope "/", CompassIO do
    pipe_through :browser # Use the default browser stack

    get "/", CaveController, :index
    resources "/caves", CaveController do
      resources "/surveys", SurveyController
    end
    resources "/maps", MapController, only: [:show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", CompassIO do
  #   pipe_through :api
  # end
end
