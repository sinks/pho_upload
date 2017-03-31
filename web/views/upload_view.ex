defmodule PhoUpload.UploadView do
  use PhoUpload.Web, :view

  import PhoUpload.Router.Helpers

  def render("new.json", %{} = data) do
     documents = Enum.map(data.documents,
      fn (doc) -> %{ self: doc_url(doc), name: doc.name } end
      )
    %{
       self: upload_url(PhoUpload.Endpoint, :get, data.id),
       documents: documents
     }
  end

  def doc_url(doc) do
    document_url(PhoUpload.Endpoint, :get, doc.id)
  end
end
