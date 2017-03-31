defmodule PhoUpload.UploadView do
  use PhoUpload.Web, :view

  def render("new.json", %{} = data) do
     documents = Enum.map(data.documents,
       fn (doc) -> %{self: doc.uri, name: doc.name} end)
    %{
       self: "/uploads/#{data.id}",
       documents: documents
     }
  end
end
