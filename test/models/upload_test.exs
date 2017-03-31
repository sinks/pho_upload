defmodule PhoUpload.UploadTest do
  use PhoUpload.ModelCase

  alias PhoUpload.Upload

  @valid_attrs %{username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Upload.changeset(%Upload{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Upload.changeset(%Upload{}, @invalid_attrs)
    refute changeset.valid?
  end
end
