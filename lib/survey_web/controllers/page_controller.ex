defmodule SurveyWeb.PageController do
  use SurveyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
