defmodule PhoUpload.DocumentView do
  use PhoUpload.Web, :view

  import PhoUpload.Router.Helpers

  def render("self.json", %{document: document}) do
    %{
      self: doc_url(document.id),
      name: document.name
    }
  end

  def doc_url(id) do
    document_url(PhoUpload.Endpoint, :get, id)
  end
end
