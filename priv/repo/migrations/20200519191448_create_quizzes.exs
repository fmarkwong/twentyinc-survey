defmodule Survey.Repo.Migrations.CreateQuizzes do
  use Ecto.Migration

  def change do
    create table(:quizzes) do
      add :title, :string
      add :description, :string
      add :image_url, :string

      timestamps()
    end
  end
end
