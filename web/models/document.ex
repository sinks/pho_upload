defmodule PhoUpload.Document do
  use PhoUpload.Web, :model

  schema "documents" do
    field :name, :string
    field :content_type, :string
    field :uri, :string
    belongs_to :upload, PhoUpload.Upload

    timestamps()
  end

  def changeset(struct, params \\ {}) do
    struct
    |> cast(params, [:name, :content_type, :uri])
    |> validate_required([:name, :content_type, :uri])
  end

  def store({name, %Plug.Upload{} = upload}) do
    save_to = "/tmp/pho_upload/#{uuid()}"
    case File.cp(upload.path, save_to) do
      :ok -> {:ok, %{uri: save_to, name: name, content_type: upload.content_type}}
      {:error, _} -> {:error}
    end
  end

  def uuid() do
    case Ecto.UUID.load(Ecto.UUID.bingenerate()) do
      {:ok, uuid} -> uuid
      {:error} -> 'asdfasdfasdf'
    end
  end

  def with_upload(query, username) do
    from q in query,
      join: u in assoc(q, :upload),
      where: u.username == ^username,
      preload: [upload: u]
  end

end
