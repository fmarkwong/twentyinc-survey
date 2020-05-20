defmodule Survey.Questionnaire.Question do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "questions" do
    field :text, :string
    has_many :choices, Survey.Questionnaire.Choice
    belongs_to :quiz, Survey.Questionnaire.Quiz

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end

  def next_unanswered_question_for(query, quiz_id, user_id) do
    from question in query,
      join: choice in assoc(question, :choices),
      left_join: answer in assoc(choice, :answers),
      where: answer.user_id == ^user_id,
      or_where: is_nil(answer.id), 
      where: question.quiz_id == ^quiz_id,
      group_by: question.id,
      having: count(answer.id) == 0,
      limit: 1
      # select: %{answer_count: count(answer.id), quiz_id: question.quiz_id, question_id: question.id}
  end
end
