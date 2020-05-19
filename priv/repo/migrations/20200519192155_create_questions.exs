defmodule Survey.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :text, :string
      add :quiz_id, references(:quizzes, on_delete: :nothing)

      timestamps()
    end

    create index(:questions, [:quiz_id])
  end
end
