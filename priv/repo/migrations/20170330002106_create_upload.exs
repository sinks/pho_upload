defmodule PhoUpload.Repo.Migrations.CreateUpload do
  use Ecto.Migration

  def change do
    create table(:uploads) do
      add :username, :string

      timestamps()
    end

  end
end
