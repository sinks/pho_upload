defmodule PhoUpload.DocumentController do
  use PhoUpload.Web, :controller

  alias PhoUpload.Auth
  alias PhoUpload.Document
  plug :authenticated

  def get(conn, %{"id" => id}) do
    document =
      Document
      |> Document.with_upload(conn.assigns[:user]["username"])
      |> Repo.get_by(%{id: id})

    case document do
      nil ->
        conn
        |> bad_request()
      struct ->
        conn
        |> put_resp_content_type(document.content_type)
        |> send_file(:ok, document.uri)
    end
  end

  def authenticated(conn, _params) do
    case Auth.authenticated(conn) do
      {:ok, user} -> assign(conn, :user, user)
      {:error} ->
        conn
        |> bad_request()
        |> halt
    end
  end

  def bad_request(conn) do
    conn
    |> put_status(:bad_request)
    |> json(%{errors: %{detail: "bad request"}})
  end
end
