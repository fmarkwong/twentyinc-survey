defmodule Survey.Questionnaire.Question do
  use Ecto.Schema
  import Ecto.Changeset

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
end
