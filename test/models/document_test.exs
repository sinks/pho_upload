defmodule PhoUpload.DocumentTest do
  use PhoUpload.ModelCase

  alias PhoUpload.Document

  @valid_attrs %{content_type: "some content", name: "some content", uri: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Document.changeset(%Document{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Document.changeset(%Document{}, @invalid_attrs)
    refute changeset.valid?
  end
end
