defmodule Survey.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :choice_id, references(:choices, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:answers, [:choice_id])
    create index(:answers, [:user_id])
  end
end
