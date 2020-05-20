defmodule SurveyWeb.Router do
  use SurveyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SurveyWeb do
    pipe_through :browser

    # get "/", PageController, :index
    get "/users", UserController, :index
    get "/", QuizController, :index
    get "/start-quiz-page/:id", QuizController, :start
    get "/next-queston-page/:quiz_id", QuizController, :next_question
    post "/submit-answer/:quiz_id", QuizController, :submit_answer
  end

  # Other scopes may use custom stacks.
  # scope "/api", SurveyWeb do
  #   pipe_through :api
  # end
end
