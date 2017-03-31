defmodule PhoUpload.Upload do
  use PhoUpload.Web, :model

  schema "uploads" do
    field :username, :string
    has_many :documents, PhoUpload.Upload

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
end
