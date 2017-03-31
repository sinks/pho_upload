defmodule PhoUpload.Repo.Migrations.CreateDocument do
  use Ecto.Migration

  def change do
    create table(:documents) do
      add :name, :string
      add :content_type, :string
      add :uri, :string
      add :upload_id, references(:uploads, on_delete: :nothing)

      timestamps()
    end
    create index(:documents, [:upload_id])

  end
end
