defmodule PhoUpload.UploadController do
  use PhoUpload.Web, :controller

  alias PhoUpload.Auth
  plug :authenticated

  def new(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{})
  end

  def authenticated(conn, _params) do
    case Auth.authenticated(conn) do
      {:error} ->
        conn
        |> put_status(:bad_request)
        |> json(%{})
    end
  end
end
