defmodule Survey.Questionnaire.Choice do
  use Ecto.Schema
  import Ecto.Changeset

  schema "choices" do
    field :text, :string
    belongs_to :question, Survey.Questionnaire.Question

    timestamps()
  end

  @doc false
  def changeset(choice, attrs) do
    choice
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
