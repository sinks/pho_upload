defmodule PhoUpload.Auth do

  import Plug.Conn
  import HTTPoison
  alias HTTPoison.Response

  def authenticated(conn) do
    token = get_req_header(conn, "authorization")
    authenticated(conn, token)
  end

  def authenticated(_conn, []) do
    {:error}
  end

  def authenticated(_conn, [token | _]) do
    url = "http://localhost:4000/authorise"
    headers = [
      "Authorization": token,
      "Accept": "application/json",
      "Content-Type": "application/json"
    ]

    case post(url, "", headers) do
      {:ok, %Response{status_code: 200, body: body}} ->
        case Poison.Parser.parse(body) do
          {:ok, token} -> {:ok, token["body"]}
          _ -> {:ok}
        end
    end
  end
end
