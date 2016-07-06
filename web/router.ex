defmodule CompassIO.Router do
  use CompassIO.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    if Mix.env != :test do
      plug BasicAuth, Application.get_env(:compassIO, :basic_auth)
    end
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CompassIO do
    pipe_through :browser # Use the default browser stack

    resources "/caves", Browser.CaveController do
      resources "/surveys", Browser.SurveyController
    end
    get "/", Browser.CaveController, :index
  end

  scope "/api/v1", CompassIO, as: :api do
    resources "/caves", Api.CaveController, except: [:new, :edit]
  end
end
