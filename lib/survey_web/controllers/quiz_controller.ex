defmodule SurveyWeb.QuizController do
  use SurveyWeb, :controller

  alias Survey.Questionnaire
  alias Survey.Questionnaire.{Quiz, Question}
  alias Survey.Repo

  def index(conn, _params) do
    current_user_id = 1 #harccoding this.  Normally would get it from session in conn
    quizzes = Questionnaire.list_quizzes_for_user(current_user_id)
    render(conn, "index.html", quizzes: quizzes)
  end

  def start(conn, %{"id" => id}) do
    render(conn, "start.html", quiz: Repo.get(Quiz, id))
  end

  def next_question(conn, quiz) do
    current_user_id = 1 #harccoding this.  Normally would get it from session in conn
    question = Question.next_unanswered_question_for(Question, quiz.id, current_user_id) 
    render(conn, "next_question.html", quiz: quiz) 
  end

  def new(conn, _params) do
    changeset = Questionnaire.change_quiz(%Quiz{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"quiz" => quiz_params}) do
    case Questionnaire.create_quiz(quiz_params) do
      {:ok, quiz} ->
        conn
        |> put_flash(:info, "Quiz created successfully.")
        |> redirect(to: Routes.quiz_path(conn, :show, quiz))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    quiz = Questionnaire.get_quiz!(id)
    render(conn, "show.html", quiz: quiz)
  end

  def edit(conn, %{"id" => id}) do
    quiz = Questionnaire.get_quiz!(id)
    changeset = Questionnaire.change_quiz(quiz)
    render(conn, "edit.html", quiz: quiz, changeset: changeset)
  end

  def update(conn, %{"id" => id, "quiz" => quiz_params}) do
    quiz = Questionnaire.get_quiz!(id)

    case Questionnaire.update_quiz(quiz, quiz_params) do
      {:ok, quiz} ->
        conn
        |> put_flash(:info, "Quiz updated successfully.")
        |> redirect(to: Routes.quiz_path(conn, :show, quiz))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", quiz: quiz, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    quiz = Questionnaire.get_quiz!(id)
    {:ok, _quiz} = Questionnaire.delete_quiz(quiz)

    conn
    |> put_flash(:info, "Quiz deleted successfully.")
    |> redirect(to: Routes.quiz_path(conn, :index))
  end
end
