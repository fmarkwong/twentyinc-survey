defmodule Survey.Questionnaire do
  @moduledoc """
  The Questionnaire context.
  """

  import Ecto.Query, warn: false
  alias Survey.Repo

  alias Survey.Questionnaire.Quiz

  @doc """
  Returns the list of quizzes
  that have not been completed
  for a user

  ## Examples
  iex> list_quizzes_for(user.id)
      [%Quiz{}, ...]

  """

  def list_not_completed_quizzes_for_user(user_id) do
    Quiz
    |> Quiz.not_completed_for(user_id)
    |> Repo.all()
  end
end
