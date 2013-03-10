defmodule ApplicationRouter do
  use Dynamo.Router

  prepare do
    # Pick which parts of the request you want to fetch
    # You can comment the line below if you don't need
    # any of them or move them to a forwarded router
    conn.fetch([:cookies, :params])
  end

  # It is common to break your Dynamo in many
  # routers forwarding the requests between them
  # forward "/posts", to: PostsRouter

  get "/" do
    conn = conn.assign(:title, "Welcome to Dynamo!")
    render conn, "index.html"
  end
  get "/md" do
    output "index.html", conn
  end
  get "/md/:page" do
    conn = conn.assign(:title, page)
    output page, conn
  end
  match ["md" |tail], via: :get do
    render conn, "error.html", [reason: :notfoundroute, page: tail]
  end
  defp output(page, conn) do
    resp = conn.resp_content_type("text/html")
    resp = resp.resp_charset("utf-8")
    case File.read(Path.join(["web", "templates", "#{page}.md"])) do
      {:ok, f} -> r = :markdown.conv_utf8(bitstring_to_list(f))
	resp.send(200, to_binary(r))
      {:error, reason} -> 
	render resp, "error.html", [reason: reason, page: page]
    end
  end
end
