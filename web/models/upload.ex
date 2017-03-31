defmodule PhoUpload.Upload do
  use PhoUpload.Web, :model

  schema "uploads" do
    field :username, :string
    has_many :documents, PhoUpload.Document

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username])
    |> validate_required([:username])
  end

  def with_documents(query) do
    from q in query, preload: [:documents]
  end

end
