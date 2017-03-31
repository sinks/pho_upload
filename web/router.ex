defmodule PhoUpload.Router do
  use PhoUpload.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/uploads", PhoUpload do
    pipe_through :api
    post "/", UploadController, :new
    get "/:id", UploadController, :get
  end

  scope "/documents", PhoUpload do
    pipe_through :api
    get "/:id", DocumentController, :get
  end
end
