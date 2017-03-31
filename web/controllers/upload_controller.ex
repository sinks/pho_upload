defmodule PhoUpload.UploadController do
  use PhoUpload.Web, :controller

  alias PhoUpload.Auth
  alias PhoUpload.Upload
  alias PhoUpload.Document
  plug :authenticated

  def get(conn, %{"id" => id}) do
    upload =
      Upload
      |> Upload.with_documents()
      |> Repo.get_by(%{"id": id, "username": conn.assigns[:user]["username"]})

    case upload do
      nil ->
        conn
        |> bad_request()
      struct ->
        # upload = Repo.preload(struct, :documents)
        conn
        |> put_status(:ok)
        |> render("new.json", upload)
    end
  end

  def new(conn, params) do
    documents =
      params
      |> Enum.filter(&is_upload/1)
      |> Enum.map(&Document.store/1)
      |> Enum.map(fn ({:ok, doc}) -> Document.changeset(%Document{}, doc) end)

    changeset =
      %Upload{}
      |> Upload.changeset(%{username: conn.assigns[:user]["username"]})
      |> Ecto.Changeset.put_assoc(:documents, documents)

    case Repo.insert(changeset) do
      {:ok, struct} ->
        conn
        |> put_status(:ok)
        |> render("new.json", struct)
      {:error, _} ->
        conn
        |> bad_request()
    end
  end

  def is_upload({_k, v}) do
   case v do
     %Plug.Upload{} -> true
     _ -> false
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
