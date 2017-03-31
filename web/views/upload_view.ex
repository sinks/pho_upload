defmodule PhoUpload.UploadView do
  use PhoUpload.Web, :view

  import PhoUpload.Router.Helpers

  def render("new.json", %{documents: documents, id: id}) do
    %{
       self: upload_url(PhoUpload.Endpoint, :get, id),
       documents: render_many(documents, PhoUpload.DocumentView, "self.json")
     }
  end
end
