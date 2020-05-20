defmodule SurveyWeb.QuizController do
  use SurveyWeb, :controller

  alias Survey.Questionnaire
  alias Survey.Questionnaire.{Answer, Quiz, Question}
  alias Survey.Repo

  @current_user_id 13 #harccoding this.  Normally would get it from session in conn

  def index(conn, _params) do
    quizzes = Questionnaire.list_quizzes_for_user(@current_user_id)
    render(conn, "index.html", quizzes: quizzes)
  end

  def start(conn, %{"id" => id}) do
    render(conn, "start.html", quiz: Repo.get(Quiz, id))
  end

  def next_question(conn, %{"quiz_id" => quiz_id}) do
    question = Question.next_unanswered_question_for(Question, String.to_integer(quiz_id), @current_user_id) 
      |> Repo.one()
      |> Repo.preload([:choices, :quiz])

    case question do
      %Question{} ->
        render(conn, "next_question.html", question: question) 
      nil ->
        render(conn, "end-quiz-page.html") 
    end
  end

  def submit_answer(conn, %{"quiz_id" => quiz_id, "choice_id" => choice_id}) do
    %Answer{}
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_change(:user_id, @current_user_id)
    |> Answer.changeset(%{choice_id: choice_id})
    |> Repo.insert()

    redirect(conn, to: Routes.quiz_path(conn, :next_question, quiz_id))
  end
end
