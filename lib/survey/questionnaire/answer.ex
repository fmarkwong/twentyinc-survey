defmodule Survey.Questionnaire.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "answers" do
    belongs_to :choice, Survey.Questionnaire.Choice
    belongs_to :user, Survey.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(answer, attrs \\ %{}) do
    answer
    |> cast(attrs, [])
    |> validate_required([])
  end
end
