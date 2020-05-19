defmodule Survey.Questionnaire.Quiz do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "quizzes" do
    field :description, :string
    field :image_url, :string
    field :title, :string
    has_many :questions, Survey.Questionnaire.Question

    timestamps()
  end

  @doc false
  def changeset(quiz, attrs) do
    quiz
    |> cast(attrs, [:title, :description, :image_url])
    |> validate_required([:title, :description, :image_url])
  end

  def not_completed_for(query, user_id) do
    from quiz in query,
      join: question in assoc(quiz, :questions),
      join: choice in assoc(question, :choices),
      left_join: answer in assoc(choice, :answers),
      where: is_nil(answer.id),
      or_where: fragment("? is DISTINCT FROM ?", answer.user_id, ^user_id),
      group_by: quiz.id,
      order_by: quiz.id
  end
end
