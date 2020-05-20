defmodule SurveyWeb.QuizController do
  use SurveyWeb, :controller

  alias Survey.Questionnaire
  alias Survey.Questionnaire.{Answer, Quiz, Question}
  alias Survey.Accounts.User
  alias Survey.Repo

  def index(conn, _params) do
    current_user = current_user(conn)

    quizzes = Questionnaire.list_not_completed_quizzes_for_user(current_user.id)
    render(conn, "index.html", quizzes: quizzes, current_user: current_user)
  end

  def start(conn, %{"id" => id}) do
    render(conn, "start.html", quiz: Repo.get(Quiz, id))
  end

  def next_question(conn, %{"quiz_id" => quiz_id}) do
    question =
      Question.next_unanswered_question_for(Question, quiz_id, current_user(conn).id)
      |> Repo.one()
      |> Repo.preload([:choices, :quiz])

    case question do
      %Question{} ->
        render(conn, "next-question.html", question: question)

      nil ->
        render(conn, "end-quiz-page.html")
    end
  end

  def submit_answer(conn, %{"quiz_id" => quiz_id, "choice_id" => choice_id}) do
    %Answer{}
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_change(:user_id, current_user(conn).id)
    |> Answer.changeset(%{choice_id: choice_id})
    |> Repo.insert()

    redirect(conn, to: Routes.quiz_path(conn, :next_question, quiz_id))
  end

  def submit_answer(conn, %{"quiz_id" => quiz_id}) do
    conn
    |> put_flash(:error, "Please make a selection")
    |> redirect(to: Routes.quiz_path(conn, :next_question, quiz_id))
  end

  defp current_user(conn) do
    id = Plug.Conn.get_session(conn, :user_id)
    Repo.get!(User, id)
  end
end
