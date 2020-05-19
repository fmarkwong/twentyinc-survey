defmodule Survey.Questionnaire.Quiz do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quizzes" do
    field :description, :string
    field :image_url, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(quiz, attrs) do
    quiz
    |> cast(attrs, [:title, :description, :image_url])
    |> validate_required([:title, :description, :image_url])
  end
end
